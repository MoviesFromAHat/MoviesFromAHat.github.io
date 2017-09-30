module Genre exposing (..)

import Set exposing (..)
import Navigation exposing (..)
import UrlParser as Url exposing (..)
import Multiselect exposing (..)


{-| A (String, String) for value, Description.
This is not a union type because making those comparable is poor.
-}
type alias Genre =
    ( String, String )


toCapital : String -> String
toCapital str =
    String.toUpper (String.left 1 str) ++ String.dropLeft 1 str


{-| Initializes a multiselect with an available and selected list
-}
genresMultiselectModel : String -> Set Genre -> Set Genre -> Multiselect.Model
genresMultiselectModel elemId available selected =
    available
        |> Set.toList
        |> (\m -> Multiselect.initModel m elemId)
        |> (\m -> { m | selected = Set.toList selected })


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
