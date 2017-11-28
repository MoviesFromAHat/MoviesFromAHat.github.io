module Genre exposing (fromQueryString, multiSelectModel, selectionView, Genre, fromFlatList)

import Set exposing (..)
import Navigation exposing (..)
import UrlParser as Url exposing (..)
import Multiselect exposing (..)
import Html exposing (Html, div, text)
import AppCss.Helpers exposing (class)
import AppCss exposing (..)


{-| A (String, String) for value, Description.
This is not a union type because making those comparable is poor.
-}
type alias Genre =
    ( String, String )


toCapital : String -> String
toCapital str =
    String.toUpper (String.left 1 str) ++ String.dropLeft 1 str


{-| Converts a List of strings to a Set of lowercase strings
-}
fromFlatList : List String -> Set Genre
fromFlatList genres =
    genres
        |> List.map (\g -> ( g, toCapital g ))
        |> Set.fromList


fromQueryString : Navigation.Location -> Set Genre
fromQueryString location =
    Url.parsePath (s "" <?> stringParam "genres") location
        |> Maybe.withDefault Nothing
        |> Maybe.withDefault ""
        |> String.split "+"
        |> List.filter (\g -> not (String.isEmpty g))
        |> fromFlatList


{-| Initializes a multiselect with an available and selected list
-}
multiSelectModel : Set Genre -> Set Genre -> Multiselect.Model
multiSelectModel available selected =
    available
        |> Set.toList
        |> (\m -> Multiselect.initModel m "genrePicker")
        |> (\m -> { m | selected = Set.toList selected })


selectionView : (Multiselect.Msg -> msg) -> Multiselect.Model -> Html msg
selectionView updateSelection model =
    div [ class [ GenreSelection ] ]
        [ text "Genres"
        , model
            |> Multiselect.view
            |> Html.map updateSelection
        ]
