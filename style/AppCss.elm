module AppCss exposing (CssClasses(..), css)

import Css exposing (..)
import Css.Media exposing (withMediaQuery)
import Css.Elements exposing (body, button, a, img)
import CssTransitions as T exposing (transition)
import Time exposing (second)


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
    | GenreSelection
    | Wrap
    | Filterable
    | Filtered
    | MovieModal
    | CloseButton
    | InfoBlock
    | LeftBar
    | RightBar


colors =
    { light = (hex "ECDFBD")
    , dark = (hex "262626")
    , lessDark = (hex "333333")
    , blue = (hex "20457C")
    , orange = (hex "FB6648")
    , other = (hex "5E3448")
    , black = (hex "000000")
    , transparent = (hex "00000000")
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
                , withMediaQuery [ "screen and (max-width: 600px)" ]
                    [ padding (px 10) ]
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


genreSelection =
    class GenreSelection
        [ width (px 400)
        , maxWidth (pct 100)
        ]


movieCard =
    class MovieCard
        [ display inlineBlock
        , margin spacing.medium
        , textDecoration none
        , textAlign center
        , verticalAlign top
        , width (px 215)
        , backgroundColor colors.transparent
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
        , withMediaQuery [ "screen and (max-width: 600px)" ]
            [ width (pct 45) ]
        ]


movieModal =
    class MovieModal
        [ width (pct 90)
        , height (pct 80)
        , maxHeight (px 500)
        , backgroundColor colors.dark
        , border2 (px 2) solid
        , position fixed
        , top zero
        , bottom zero
        , left zero
        , right zero
        , margin auto
        , borderRadius (px 5)
        , padding (px 10)
        , displayFlex
        , overflow auto
        , transition
            [ T.height (second * 0.3)
            , T.width (second * 0.3)
            , T.padding (second * 0.3)
            , T.margin (second * 0.3)
            ]
        , descendants
            [ img
                [ height (px 326)
                ]
            ]
        , withMediaQuery [ "screen and (max-width: 600px)" ]
            [ display block, maxHeight none ]
        ]


infoBlock =
    class InfoBlock
        [ displayFlex
        , flexDirection column
        , flex auto
        , descendants
            [ Css.Elements.ul
                [ listStyleType none
                , padding zero
                , textAlign center
                , fontSize (px 18)
                ]
            , Css.Elements.a [ padding2 zero (px 5) ]
            ]
        ]


leftBar =
    class LeftBar
        [ displayFlex
        , flexDirection column
        , flex auto
        , flexShrink zero
        , maxWidth (px 300)
        , padding (px 10)
        , alignItems center
        , withMediaQuery [ "screen and (max-width: 600px)" ]
            [ maxWidth none ]
        ]


rightBar =
    class RightBar
        [ displayFlex
        , flex auto
        , padding (px 10)
        ]


closeButton =
    class CloseButton
        [ position absolute
        , right (px 5)
        , top (px 5)
        , padding (px 5)
        , backgroundColor colors.transparent
        ]


filterable =
    class Filterable
        [ transition
            [ T.height (second * 0.3)
            , T.width (second * 0.3)
            , T.margin (second * 0.3)
            ]
        , overflow hidden
        ]


filtered =
    class Filtered
        [ width (px 0)
        , height (px 0)
        , margin (px 0)
        , padding zero
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
               , genreSelection
               , filtered
               , filterable
               , movieModal
               , closeButton
               , infoBlock
               , rightBar
               , leftBar
               ]
        )
