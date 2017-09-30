module Main exposing (..)

-- Our Imports

import Movie exposing (Movie, movieCard, matchGenres)
import Genre exposing (..)
import MovieList exposing (..)
import AppCss.Helpers exposing (class)
import AppCss exposing (..)


-- External Imports

import Html exposing (Html, div, h2, button, text, a)
import Html.Attributes exposing (href, id, type_)
import Html.Events exposing (onClick)
import Markdown
import Multiselect exposing (..)
import Time.Date as Date exposing (date)
import Random
import Random.List as RandList
import Set exposing (Set)
import Navigation
import UrlParser as Url exposing ((<?>), s, stringParam, parsePath)


main : Program Never Model Msg
main =
    Navigation.program
        LocationChange
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }



-- Model


type alias Model =
    { unwatched : List Movie
    , watched : List Movie
    , selectedMovie : MovieSelection
    , genres : Set Genre
    , selectedGenres : Set Genre
    , genresMultiselect : Multiselect.Model
    , location : Navigation.Location
    }


type MovieSelection
    = NotSelected
    | Selected Movie
    | NothingToSelect


init : Navigation.Location -> ( Model, Cmd Msg )
init location =
    let
        watchDate movie =
            Movie.watchDate movie
                |> Maybe.withDefault (date 1800 1 1)

        genres =
            MovieList.movies
                |> List.map .genres
                |> List.foldr Set.union Set.empty

        selectOptions set =
            set

        -- Get selected genres out of the url like ?genres=horror+sci-fi
        queryGenres =
            fromQueryString location
    in
        { unwatched =
            MovieList.movies
                |> List.filter (not << Movie.isWatched)
                |> List.sortBy .year
        , watched =
            MovieList.movies
                |> List.filter Movie.isWatched
                |> List.sortWith
                    (\m1 m2 ->
                        Date.compare (watchDate m1) (watchDate m2)
                    )
        , selectedMovie = NotSelected
        , genres = genres
        , selectedGenres = queryGenres
        , genresMultiselect = genresMultiselectModel "genres" genres queryGenres
        , location = location
        }
            ! []



-- Update


type Msg
    = SelectMovie
    | MovieSelected ( Maybe Movie, List Movie )
    | MultiselectEvent Multiselect.Msg
    | LocationChange Navigation.Location


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        LocationChange location ->
            ( model, Cmd.none )

        SelectMovie ->
            ( model
            , model.unwatched
                |> List.filter (matchGenres model.selectedGenres)
                |> RandList.choose
                |> Random.generate MovieSelected
            )

        MovieSelected ( selection, remaining ) ->
            let
                selected =
                    case selection of
                        Just movie ->
                            Selected movie

                        Nothing ->
                            NothingToSelect
            in
                ( { model
                    | unwatched = remaining
                    , selectedMovie = selected
                  }
                , Cmd.none
                )

        MultiselectEvent subscriptionEvent ->
            let
                ( subModel, subCmd ) =
                    Multiselect.update subscriptionEvent model.genresMultiselect

                selectedGenres =
                    subModel.selected
                        |> Set.fromList

                newUrl =
                    case List.length subModel.selected of
                        0 ->
                            model.location.origin

                        _ ->
                            subModel.selected
                                |> List.map (\( m, n ) -> m)
                                |> String.join "+"
                                |> (++)
                                    (model.location.origin
                                        ++ "?genres="
                                    )
            in
                { model
                    | genresMultiselect = subModel
                    , selectedGenres = selectedGenres
                }
                    ! [ Cmd.map MultiselectEvent subCmd, Navigation.modifyUrl newUrl ]



-- View


view : Model -> Html Msg
view model =
    let
        watchDate movie =
            Movie.watchDate movie
                |> Maybe.withDefault (date 1800 1 1)
    in
        div []
            [ a [ id "movies" ] []
            , appHeader model
            , div []
                [ h2 [] [ text "Unwatched Films" ]
                , div [ class [ Movies ] ]
                    (model.unwatched
                        |> List.map (Movie.movieCard model.selectedGenres)
                    )
                , h2 [] [ text "Watched" ]
                , div [ class [ Movies ] ]
                    (model.watched
                        |> List.map (Movie.movieCard model.selectedGenres)
                    )
                ]
            , rulesView
            ]


rulesView : Html Msg
rulesView =
    div []
        [ a [ id "rules" ] []
        , h2 [] [ text "The Rules" ]
        , Markdown.toHtml [] """

### Selecting the Movie

1. The movie is selected at random just before we watch. No one will know what the selection is until the event.
2. A movie can be removed from the list by a majority vote (but see #3)
3. You can only vote to remove a movie if you have seen it
4. A movie can be tabled to be watched later by a majority vote.
5. Anyone can vote to table a movie.
6. A vote to remove also counts as a vote to table.
7. Be reasonable. If somebody's uncomfortable watching something, or finds it offensive, just skip it.

### Adding movies to the list

1. Anyone can add movies to the list.
2. Movies can be added to the list via a PR against the [git repo](https://github.com/MoviesFromAHat/MoviesFromAHat.github.io/)
3. We're looking for movies that flew under the radar, not blockbusters. (Think "Krull", not "Lord of the Rings")
4. Use common sense. You'll be watching this with your co-workers. Be mindful of them and the power differentials that exist in the workspace.
5. No Troma Films. (The Cheely Rule)
"""
        ]


selectionView : Model -> Html Msg
selectionView model =
    div [ class [ Selection ] ]
        [ case model.selectedMovie of
            Selected movie ->
                Movie.movieCard Set.empty movie

            NotSelected ->
                text ""

            NothingToSelect ->
                text "Sorry, it looks like the hat is empty."
        ]


selectionControls : Html Msg
selectionControls =
    div [ class [ SelectionControls ] ]
        [ button [ onClick SelectMovie, type_ "button" ]
            [ text "Pull a movie from the hat" ]
        ]


appHeader : Model -> Html Msg
appHeader model =
    div [ class [ Header ] ]
        [ div [ class [ Navigation ] ]
            [ a [ href "#movies" ] [ text "The Movies" ]
            , a [ href "#rules" ] [ text "The Rules" ]
            ]
        , selectionControls
        , selectionView model
        , genreSelection model
        ]


genreSelection : Model -> Html Msg
genreSelection model =
    div [ class [ GenreSelection ] ]
        [ text "Genres"
        , model.genresMultiselect
            |> Multiselect.view
            |> Html.map MultiselectEvent
        ]



-- Subscriptions


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.map MultiselectEvent <| Multiselect.subscriptions model.genresMultiselect
