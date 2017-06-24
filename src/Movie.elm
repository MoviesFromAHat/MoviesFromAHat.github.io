module Movie exposing (..)

import Html exposing (Html, div, img, text, a)
import Html.Attributes exposing (src, href, target)
import AppCss.Helpers exposing (class)
import AppCss as Style
import Time.Date exposing (Date, day, month, year)


-- Types


type alias Movie =
    { title : String
    , url : String
    , img : String
    , year : Int
    , runtime : Int
    , genres : List String
    , watched : WatchState
    }


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



-- Views


movieCard : Movie -> Html msg
movieCard movie =
    a
        [ class [ Style.MovieCard ]
        , href movie.url
        , target "_blank"
        ]
        [ img
            [ class [ Style.Poster ]
            , src ("posters/" ++ movie.img)
            ]
            []
        , div
            [ class [ Style.Title ] ]
            [ text movie.title ]
        , notesView movie
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
