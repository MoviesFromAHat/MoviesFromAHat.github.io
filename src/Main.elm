module Main exposing (..)

import Html exposing (Html, div, h2, button, text, a)
import Html.Attributes exposing (href, id, type_)
import Html.Events exposing (onClick)
import Movie exposing (Movie, movieCard)
import MovieList exposing (..)
import AppCss.Helpers exposing (class)
import AppCss exposing (..)
import Time.Date as Date exposing (date)
import Random
import Random.List as RandList
import Markdown


main : Program Never Model Msg
main =
    Html.program
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
    }


type MovieSelection
    = NotSelected
    | Selected Movie
    | NothingToSelect


init : ( Model, Cmd Msg )
init =
    let
        watchDate movie =
            Movie.watchDate movie
                |> Maybe.withDefault (date 1800 1 1)
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
        }
            ! []



-- Update


type Msg
    = SelectMovie
    | MovieSelected ( Maybe Movie, List Movie )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SelectMovie ->
            ( model
            , Random.generate
                MovieSelected
                (RandList.choose model.unwatched)
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
                { model
                    | unwatched = remaining
                    , selectedMovie = selected
                }
                    ! []



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
                    (List.map Movie.movieCard model.unwatched)
                , h2 [] [ text "Watched" ]
                , div [ class [ Movies ] ]
                    (List.map Movie.movieCard model.watched)
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
                Movie.movieCard movie

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
        ]



-- Subscriptions


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none
