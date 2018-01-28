module Movie exposing (..)

import Html exposing (Html, div, img, text, a, button, p, h2, ul, b, li)
import Html.Attributes exposing (src, href, target, type_, autofocus)
import Html.Events exposing (onClick)
import AppCss.Helpers exposing (class, classList)
import AppCss as Style
import Time.Date exposing (Date, day, month, year)
import Set exposing (Set)
import Genre exposing (Genre)
import Json.Decode as Decode exposing (string, list)
import Json.Decode.Pipeline exposing (decode, hardcoded, optional, required)


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
    }


type alias Rating =
    { source : String
    , value : String
    }


type alias MovieDetails =
    { movie : Movie
    , rated : String
    , runtime : String
    , director : String
    , writer : String
    , actors : String
    , plot : String
    , ratings : List Rating
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


ratingDecoder : Decode.Decoder Rating
ratingDecoder =
    Json.Decode.Pipeline.decode Rating
        |> Json.Decode.Pipeline.required "Source" Decode.string
        |> Json.Decode.Pipeline.required "Value" Decode.string


type alias JustWatchSearchResult =
    { title : String
    , id : Int
    }


type alias JustWatchSearchResults =
    { items : List JustWatchSearchResult
    }


type alias JustWatchDetails =
    { offers : List JustWatchOffer
    }


decodeJustWatchSearch : Movie -> Decode.Decoder JustWatchSearchResults
decodeJustWatchSearch movie =
    Json.Decode.Pipeline.decode JustWatchSearchResults
        |> Json.Decode.Pipeline.required "items" (Decode.list searchResultDecoder)


searchResultDecoder =
    Json.Decode.Pipeline.decode JustWatchSearchResult
        |> Json.Decode.Pipeline.required "title" Decode.string
        |> Json.Decode.Pipeline.required "id" Decode.int


type OfferType
    = BuyVideo
    | RentVideo
    | StreamVideo


offerTypeDecoder : Decode.Decoder OfferType
offerTypeDecoder =
    Decode.string
        |> Decode.andThen
            (\str ->
                case str of
                    "buy" ->
                        Decode.succeed BuyVideo

                    "flatrate" ->
                        Decode.succeed StreamVideo

                    "rent" ->
                        Decode.succeed RentVideo

                    other ->
                        Decode.fail <| "Unknown offertype: " ++ other
            )


type PresentationType
    = HD
    | SD


presentationTypeDecoder : Decode.Decoder PresentationType
presentationTypeDecoder =
    Decode.string
        |> Decode.andThen
            (\str ->
                case str of
                    "hd" ->
                        Decode.succeed HD

                    "sd" ->
                        Decode.succeed SD

                    other ->
                        Decode.fail <| "Unknown PresentationType: " ++ other
            )


type Provider
    = Apple
    | Microsoft
    | GooglePlay
    | Hulu
    | Netflix
    | Amazon
    | Fandango
    | Vudu
    | Other


providerDecoder : Decode.Decoder Provider
providerDecoder =
    Decode.int
        |> Decode.andThen
            (\providerId ->
                case providerId of
                    15 ->
                        Decode.succeed Hulu

                    9 ->
                        Decode.succeed Amazon

                    10 ->
                        Decode.succeed Amazon

                    68 ->
                        Decode.succeed Microsoft

                    3 ->
                        Decode.succeed GooglePlay

                    105 ->
                        Decode.succeed Fandango

                    7 ->
                        Decode.succeed Vudu

                    2 ->
                        Decode.succeed Apple

                    other ->
                        Decode.succeed Other
            )


type alias JustWatchOffer =
    { offerType : OfferType
    , provider : Provider
    , url : String
    }


decodeJustWatchOffer : Decode.Decoder JustWatchOffer
decodeJustWatchOffer =
    Json.Decode.Pipeline.decode JustWatchOffer
        |> Json.Decode.Pipeline.required "monetization_type" offerTypeDecoder
        |> Json.Decode.Pipeline.required "provider_id" providerDecoder
        |> Json.Decode.Pipeline.requiredAt [ "urls", "standard_web" ] Decode.string


decodeJustWatchDetails : Decode.Decoder JustWatchDetails
decodeJustWatchDetails =
    Json.Decode.Pipeline.decode JustWatchDetails
        |> Json.Decode.Pipeline.required "offers" (Decode.list decodeJustWatchOffer)


type WatchState
    = Unwatched
    | Watched Date



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
