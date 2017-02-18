module Login.Commands exposing (..)

import Http
import Json.Decode as Decode exposing (field, decodeString)
import Json.Encode as Encode
import Login.Messages exposing (Msg(..))
import Login.Models exposing (LoginForm)
import Models exposing (Model)
import Models exposing (Model)
import Task


authUrl : String -> String
authUrl endpoint =
    endpoint ++ "/sessions/new"


authMe : Model -> LoginForm -> Cmd Msg
authMe model loginForm =
    loginRequest model loginForm
        |> Http.send OnAuth


loginRequest : Model -> LoginForm -> Http.Request String
loginRequest model loginForm =
    Http.request
        { body = encodeLogin loginForm |> Http.jsonBody
        , expect = Http.expectJson tokenDecoder
        , headers = []
        , method = "POST"
        , timeout = Nothing
        , url = authUrl model.apiEndpoint
        , withCredentials = False
        }

encodeLogin : LoginForm -> Encode.Value
encodeLogin loginForm =
    Encode.object
        [ ("username", Encode.string loginForm.username)
        , ("password", Encode.string loginForm.password)
        ]


tokenDecoder : Decode.Decoder String
tokenDecoder =
    (Decode.at ["data", "token"] Decode.string)
