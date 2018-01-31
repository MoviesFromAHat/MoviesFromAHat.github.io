module Main exposing (..)

-- Our Imports

import Movie exposing (Movie, movieCard, matchGenres, MovieDetails, MovieSelection, movieModal, offlineMovieModal)
import Genre exposing (Genre)
import MovieList exposing (..)
import AppCss.Helpers exposing (class)
import AppCss exposing (..)
import JustWatch exposing (JustWatchSearchResults, JustWatchSearchResult, JustWatchDetails, MovieOffers)


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
import Http
import Task exposing (andThen)
import List.Extra exposing (uniqueBy)
import Dict


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
    , focusedMovie : MovieSelection
    , genres : Set Genre
    , selectedGenres : Set Genre
    , genresMultiselect : Multiselect.Model
    , location : Navigation.Location
    }


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
            Genre.fromQueryString location
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
        , focusedMovie = Movie.NotSelected
        , genres = genres
        , selectedGenres = queryGenres
        , genresMultiselect = Genre.multiSelectModel genres queryGenres
        , location = location
        }
            ! []



-- Update


type Msg
    = SelectMovie
    | MovieSelected ( Maybe Movie, List Movie )
    | FocusMovie Movie
    | CloseModal
    | MultiselectEvent Multiselect.Msg
    | LocationChange Navigation.Location
    | LoadMovie (Result Http.Error MovieDetails)
    | LoadJustWatchDetails MovieDetails


fetchMovie : Movie -> Cmd Msg
fetchMovie movie =
    let
        url =
            "http://www.omdbapi.com/?apiKey=6f7301bf&t=" ++ movie.title

        request =
            Http.get url (Movie.decodeMovieData movie)
    in
        Http.send LoadMovie request



-- Search Justwatch.com for movie details


searchJustWatch : MovieDetails -> Cmd Msg
searchJustWatch movie =
    let
        url =
            JustWatch.movieSearchUrl movie.movie.title

        request =
            Http.get url JustWatch.decodeJustWatchSearch
                |> Http.toTask
                |> andThen (handleJustWatchSearchResults movie)
    in
        Task.attempt (handleJustWatchDetails movie) request


handleJustWatchSearchResults : MovieDetails -> JustWatchSearchResults -> Task.Task Http.Error JustWatchDetails
handleJustWatchSearchResults movie searchResults =
    let
        match =
            searchResults.items
                |> List.filter (\m -> m.title == movie.movie.title)
                |> List.head
    in
        case match of
            Nothing ->
                -- We got a response, but it didn't have any matching items, so fail with 404
                Http.Response "" { code = 404, message = "Not Found" } Dict.empty ""
                    |> Http.BadStatus
                    |> Task.fail

            Just result ->
                let
                    url =
                        JustWatch.movieDetailUrl result.id
                in
                    Http.get url JustWatch.decodeJustWatchDetails
                        |> Http.toTask


handleJustWatchDetails : MovieDetails -> Result e JustWatchDetails -> Msg
handleJustWatchDetails movie result =
    case result of
        Ok justWatchDetails ->
            let
                offers =
                    justWatchDetails.offers
                        |> List.sortBy (\a -> (toString a.offerType))
                        |> List.reverse
                        |> uniqueBy (\m -> m.url)

                newMovieDetails =
                    if List.isEmpty offers then
                        { movie | offers = JustWatch.NoResults }
                    else
                        { movie | offers = JustWatch.Results offers }
            in
                LoadJustWatchDetails newMovieDetails

        Err e ->
            LoadJustWatchDetails { movie | offers = JustWatch.NoResults }



-- end justwatch


openModal : Model -> Movie -> ( Model, Cmd Msg )
openModal model movie =
    ( { model | focusedMovie = Movie.Selected movie }, fetchMovie movie )


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
            case selection of
                Just movie ->
                    openModal { model | unwatched = remaining } movie

                Nothing ->
                    ( model, Cmd.none )

        FocusMovie movie ->
            openModal model movie

        CloseModal ->
            ( { model | focusedMovie = Movie.NotSelected }, Cmd.none )

        LoadMovie result ->
            case result of
                Ok movie ->
                    ( { model
                        | focusedMovie = Movie.Loaded movie
                      }
                    , searchJustWatch movie
                    )

                _ ->
                    ( model, Cmd.none )

        LoadJustWatchDetails movieDetails ->
            -- when results are loaded, we don't want to use them unless the movie is still focused
            case model.focusedMovie of
                Movie.Loaded focusedMovie ->
                    if movieDetails.movie.title == focusedMovie.movie.title then
                        ( { model | focusedMovie = Movie.Loaded movieDetails }, Cmd.none )
                    else
                        ( model, Cmd.none )

                _ ->
                    ( model, Cmd.none )

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

        modal =
            case model.focusedMovie of
                Movie.Loaded movieDetails ->
                    movieModal movieDetails CloseModal

                Movie.Selected movie ->
                    offlineMovieModal movie CloseModal

                _ ->
                    div [] []
    in
        div []
            [ a [ id "movies" ] []
            , appHeader model
            , modal
            , div []
                [ h2 [] [ text "Unwatched Films" ]
                , div [ class [ Movies ] ]
                    (model.unwatched
                        |> List.map (Movie.movieCard FocusMovie model.selectedGenres)
                    )
                , h2 [] [ text "Watched" ]
                , div [ class [ Movies ] ]
                    (model.watched
                        |> List.map (Movie.movieCard FocusMovie model.selectedGenres)
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
7. Review the rating & content warnings for the movie. Anyone can veto a movie for content. <sup>*</sup>


<sup>*</sup>If a movie is vetoed for content, even if it was your favorite movie ever, please keep your disappointment to yourself.
    Even in jest, this can make people feel like they're not welcome because they're "spoiling the fun"

### Adding movies to the list

1. Anyone can add movies to the list.
2. Movies can be added to the list via a PR against the [git repo](https://github.com/MoviesFromAHat/MoviesFromAHat.github.io/)
3. We're looking for movies that flew under the radar, not blockbusters. (Think "Krull", not "Lord of the Rings")
4. Use common sense. You'll be watching this with your co-workers. Be mindful of them and the power differentials that exist in the workspace.
5. No Troma Films. (The Cheely Rule)
"""
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
        , Genre.selectionView MultiselectEvent model.genresMultiselect
        ]



-- Subscriptions


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.map MultiselectEvent <| Multiselect.subscriptions model.genresMultiselect
