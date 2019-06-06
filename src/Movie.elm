module Movie exposing (..)

import Html exposing (Html, div, img, text, a, button, p, h2, h5, ul, b, li)
import Html.Attributes exposing (src, href, target, type_, autofocus)
import Html.Events exposing (onClick)
import AppCss.Helpers exposing (class, classList)
import AppCss as Style
import Time.Date exposing (Date, day, month, year)
import Set exposing (Set)
import Genre exposing (Genre)
import Json.Decode as Decode exposing (string, list)
import Json.Decode.Pipeline exposing (decode, hardcoded, optional, required)
import JustWatch


-- Types


type MovieSelection
    = NotSelected
    | Selected Movie
    | Loaded MovieDetails


type alias Movie =
    { title : String
    , url : String
    , img : String
    , year : Int
    , runtime : Int
    , genres : Set Genre
    , watched : WatchState
    , nsfw : Bool
    }


type alias Rating =
    { source : String
    , value : String
    }


type WatchState
    = Unwatched
    | Watched Date


type alias MovieDetails =
    { movie : Movie
    , rated : String
    , runtime : String
    , director : String
    , writer : String
    , actors : String
    , plot : String
    , ratings : List Rating
    , offers : JustWatch.MovieOffers
    }


decodeMovieData : Movie -> Decode.Decoder MovieDetails
decodeMovieData movie =
    Json.Decode.Pipeline.decode MovieDetails
        |> Json.Decode.Pipeline.hardcoded movie
        |> Json.Decode.Pipeline.required "Rated" Decode.string
        |> Json.Decode.Pipeline.required "Runtime" Decode.string
        |> Json.Decode.Pipeline.required "Director" Decode.string
        |> Json.Decode.Pipeline.required "Writer" Decode.string
        |> Json.Decode.Pipeline.required "Actors" Decode.string
        |> Json.Decode.Pipeline.required "Plot" Decode.string
        |> Json.Decode.Pipeline.required "Ratings" (Decode.list ratingDecoder)
        |> Json.Decode.Pipeline.hardcoded JustWatch.Loading


ratingDecoder : Decode.Decoder Rating
ratingDecoder =
    Json.Decode.Pipeline.decode Rating
        |> Json.Decode.Pipeline.required "Source" Decode.string
        |> Json.Decode.Pipeline.required "Value" Decode.string



-- Helpers


isWatched : Movie -> Bool
isWatched movie =
    case movie.watched of
        Unwatched ->
            False

        Watched _ ->
            True


watchDate : Movie -> Maybe Date
watchDate movie =
    case movie.watched of
        Unwatched ->
            Nothing

        Watched date ->
            Just date


matchGenres : Set Genre -> Movie -> Bool
matchGenres genres movie =
    case Set.size genres of
        0 ->
            True

        _ ->
            Set.size (Set.intersect genres movie.genres) > 0



-- Views


moviePoster : Movie -> Html msg
moviePoster movie =
    img
        [ class [ Style.Poster ]
        , src ("posters/" ++ movie.img)
        ]
        []


movieCard : (Movie -> msg) -> Set Genre -> Movie -> Html msg
movieCard focusMovie selectedGenres movie =
    let
        filtered =
            case Set.size selectedGenres of
                0 ->
                    False

                _ ->
                    Set.size (Set.intersect movie.genres selectedGenres) == 0
    in
        button
            [ classList
                [ ( Style.MovieCard, True )
                , ( Style.Filterable, True )
                , ( Style.Filtered, filtered )
                ]
            , onClick <| focusMovie <| movie
            , type_ "button"
            ]
            [ moviePoster movie
            , div
                [ class [ Style.Title ] ]
                [ text movie.title ]
            , notesView movie
            ]


ratingsList : List Rating -> Html msg
ratingsList ratings =
    ratings
        |> List.map (\l -> li [] [ text (l.source ++ " - "), b [] [ text l.value ] ])
        |> ul []


movieModalBase : msg -> List (Html msg) -> Html msg
movieModalBase closeModal contents =
    div
        [ class [ Style.MovieModal ]
        ]
        ([ button
            [ class [ Style.CloseButton ]
            , onClick closeModal
            , autofocus True
            ]
            [ text "❌"
            ]
         ]
            ++ contents
        )


movieOffer : JustWatch.Offer -> List (Html msg)
movieOffer offer =
    [ a [ href offer.url, target "_blank" ]
        [ text ((toString offer.provider) ++ " " ++ (toString offer.offerType))
        ]
    ]


movieOffers : MovieDetails -> Html msg
movieOffers movie =
    case movie.offers of
        JustWatch.Loading ->
            h5 [] [ text "Searching for movie viewing options..." ]

        JustWatch.NoResults ->
            h5 [] [ text "Movie not found for streaming or purchase" ]

        JustWatch.Results offers ->
            div []
                [ h5 [] [ text "Watch" ]
                , div [ class [ Style.Grid ] ]
                    (offers
                        |> List.map (\offer -> div [ class [ Style.GridBlock ] ] (movieOffer offer))
                    )
                ]


movieModal : MovieDetails -> msg -> Html msg
movieModal movie closeModal =
    movieModalBase closeModal
        [ div [ class [ Style.LeftBar ] ]
            [ moviePoster movie.movie
            , div [ class [ Style.InfoBlock ] ]
                [ ratingsList movie.ratings ]
            ]
        , div [ class [ Style.RightBar, Style.InfoBlock ] ]
            [ h2 []
                [ a [ href movie.movie.url, target "_blank" ] [ text movie.movie.title ]
                , text (" - " ++ (toString movie.movie.year) ++ " - Rated " ++ movie.rated ++ " - " ++ movie.runtime)
                ]
            , p [] [ text movie.plot ]
            , p [] [ text ("Directed by " ++ movie.director ++ ". Written by " ++ movie.writer ++ ".") ]
            , p [] [ text ("Starring " ++ movie.actors) ]
            , div []
                (movie.movie.genres
                    |> Set.toList
                    |> List.map (\( g, t ) -> a [ href ("?genres=" ++ g) ] [ text t ])
                )
            , movieOffers movie
            ]
        ]


offlineMovieModal : Movie -> msg -> Html msg
offlineMovieModal movie closeModal =
    movieModalBase closeModal
        [ div [ class [ Style.LeftBar ] ]
            [ moviePoster movie ]
        , div [ class [ Style.RightBar, Style.InfoBlock ] ]
            [ h2 []
                [ a [ href movie.url, target "_blank" ] [ text movie.title ]
                , text (" - " ++ (toString movie.year) ++ " - " ++ (toString movie.runtime) ++ "min")
                ]
            , div []
                (movie.genres
                    |> Set.toList
                    |> List.map (\( g, t ) -> a [ href ("?genres=" ++ g) ] [ text t ])
                )
            ]
        ]


notesView : Movie -> Html msg
notesView movie =
    case movie.watched of
        Unwatched ->
            div [ class [ Style.Notes ] ]
                [ text <|
                    (toString movie.year)
                        ++ ", "
                        ++ (toString movie.runtime)
                        ++ " min"
                ]

        Watched date ->
            div [ class [ Style.Notes ] ]
                [ text <|
                    (toString (month date))
                        ++ "."
                        ++ (toString (day date))
                        ++ "."
                        ++ (toString (year date))
                ]
