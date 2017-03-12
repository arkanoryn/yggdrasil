port module Ports exposing (..)

import Json.Decode as Decode exposing (field)
import Json.Encode
import Messages exposing (Msg(..))
import Models exposing (Flags)


sendToStorage : String -> String -> Cmd msg
sendToStorage token username =
    Json.Encode.object
        [ ( "user", Json.Encode.string username )
        , ( "token", Json.Encode.string token )
        ]
        |> save


mapStorage : Decode.Value -> Msg
mapStorage flagsJson =
    case (decodeFlags flagsJson) of
        Ok flags ->
            SetFlags flags

        _ ->
            NoOp


decodeFlags : Decode.Value -> Result String Flags
decodeFlags flagsJson =
    Decode.decodeValue flagsDecoder flagsJson


flagsDecoder : Decode.Decoder Flags
flagsDecoder =
    Decode.map2 Flags
        (field "user" Decode.string)
        (field "token" Decode.string)


port save : Json.Encode.Value -> Cmd msg


port retrieve : (Decode.Value -> msg) -> Sub msg
