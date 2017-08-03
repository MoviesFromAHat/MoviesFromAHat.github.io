module AppCss exposing (CssClasses(..), css)

import Css exposing (..)
import Css.Elements exposing (body, button, a)


type CssClasses
    = MovieCard
    | Movies
    | Poster
    | Selection
    | SelectionControls
    | Title
    | Header
    | Navigation
    | Notes


colors =
    { light = (hex "ECDFBD")
    , dark = (hex "262626")
    , lessDark = (hex "333333")
    , blue = (hex "20457C")
    , orange = (hex "FB6648")
    , other = (hex "5E3448")
    , black = (hex "000000")
    }


spacing =
    { small = (px 4)
    , medium = (px 8)
    , large = (px 16)
    }


general : List Snippet
general =
    [ body
        [ backgroundColor colors.dark
        , color colors.light
        , fontFamilies [ "Montserrat", "sans-serif" ]
        , padding spacing.large
        , paddingTop zero
        ]
    , button
        [ backgroundColor colors.blue
        , borderStyle none
        , color colors.light
        , padding2 spacing.medium spacing.large
        , borderRadius spacing.small
        , (cursor pointer)
        ]
    , a
        [ color colors.light
        , textDecoration underline
        , hover
            [ textDecoration underline ]
        ]
    ]


header =
    class Header
        [ position sticky
        , top (px 0)
        , backgroundColor colors.dark
        , padding spacing.large
        , descendants
            [ class Navigation
                [ displayFlex
                , flexDirection row
                , justifyContent spaceAround
                ]
            , class SelectionControls
                [ textAlign center
                ]
            ]
        , boxShadow5
            (px 0)
            (px 30)
            (px 35)
            (px -20)
            colors.black
        ]


movieCard =
    class MovieCard
        [ display inlineBlock
        , margin spacing.medium
        , textDecoration none
        , textAlign center
        , verticalAlign top
        , width (px 215)
        , descendants
            [ class Poster
                [ maxWidth (pct 100)
                , width (pct 100)
                ]
            , class Title
                [ margin (spacing.small) ]
            , class Notes
                [ fontSize (Css.rem 0.9) ]
            ]
        ]


movieSelection =
    class Selection
        [ margin auto
        , width (px 500)
        , textAlign center
        ]


moviesList =
    class Movies
        [ textAlign center
        ]


css : Stylesheet
css =
    stylesheet
        (general
            ++ [ header
               , movieCard
               , movieSelection
               , moviesList
               ]
        )
