port module Stylesheets exposing (..)

import Css
import Css.File exposing (CssFileStructure, CssCompilerProgram)
import Css.Normalize as Normalize
import AppCss
import GenreSelectCss


styles : List Css.Stylesheet
styles =
    [ Normalize.css
    , AppCss.css
    , GenreSelectCss.css
    ]


port files : CssFileStructure -> Cmd msg


fileStructure : CssFileStructure
fileStructure =
    Css.File.toFileStructure
        [ ( "style.css", Css.File.compile styles ) ]


main : CssCompilerProgram
main =
    Css.File.compiler files fileStructure
