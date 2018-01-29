module JustWatchProviders exposing (..)

import Json.Decode as Decode exposing (string, list)
import Json.Decode.Pipeline exposing (decode, hardcoded, optional, required)


type OfferType
    = Buy
    | Rent
    | Streaming
    | Ads
    | Free
    | Unknown


offerTypeDecoder : Decode.Decoder OfferType
offerTypeDecoder =
    Decode.string
        |> Decode.andThen
            (\str ->
                case str of
                    "buy" ->
                        Decode.succeed Buy

                    "flatrate" ->
                        Decode.succeed Streaming

                    "rent" ->
                        Decode.succeed Rent

                    "ads" ->
                        Decode.succeed Ads

                    "free" ->
                        Decode.succeed Free

                    unknown ->
                        Decode.succeed Unknown
            )


type Provider
    = Itunes
    | Microsoft
    | GooglePlay
    | Hulu
    | Netflix
    | Amazon
    | Fandango
    | Vudu
    | PlayStation
    | Starz
    | Crackle
    | Epix
    | Showtime
    | Filmstruck
    | Fandor
    | TubiTV
    | Yahoo
    | HBO_Go
    | HBO_Now
    | MaxGo
    | Shudder
    | FX
    | Realeyz
    | Other


providerDecoder : Decode.Decoder Provider
providerDecoder =
    Decode.int
        |> Decode.andThen
            (\providerId ->
                case providerId of
                    2 ->
                        Decode.succeed Itunes

                    3 ->
                        Decode.succeed GooglePlay

                    7 ->
                        Decode.succeed Vudu

                    8 ->
                        Decode.succeed Netflix

                    9 ->
                        Decode.succeed Amazon

                    10 ->
                        Decode.succeed Amazon

                    12 ->
                        Decode.succeed Crackle

                    14 ->
                        Decode.succeed Realeyz

                    15 ->
                        Decode.succeed Hulu

                    18 ->
                        Decode.succeed PlayStation

                    25 ->
                        Decode.succeed Fandor

                    27 ->
                        Decode.succeed HBO_Now

                    31 ->
                        Decode.succeed HBO_Go

                    34 ->
                        Decode.succeed Epix

                    37 ->
                        Decode.succeed Showtime

                    43 ->
                        Decode.succeed Starz

                    68 ->
                        Decode.succeed Microsoft

                    73 ->
                        Decode.succeed TubiTV

                    92 ->
                        Decode.succeed Yahoo

                    99 ->
                        Decode.succeed Shudder

                    102 ->
                        Decode.succeed Filmstruck

                    105 ->
                        Decode.succeed Fandango

                    123 ->
                        Decode.succeed FX

                    139 ->
                        Decode.succeed MaxGo

                    other ->
                        Decode.succeed Other
            )
