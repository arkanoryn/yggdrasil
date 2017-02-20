module Users.Commands exposing (..)

import Http
import Json.Decode as Decode exposing (field)
import Json.Encode as Encode
import Models exposing (Model)
import Task
import Users.Messages exposing (Msg(..))
import Users.Models


registerUrl : Model -> String
registerUrl model =
    model.apiEndpoint ++ "users"


userEncoder : Users.Models.User -> Encode.Value
userEncoder user =
    Encode.object
        [ ( "user"
          , Encode.object
                [ ( "username", Encode.string user.username )
                , ( "email", Encode.string user.email )
                , ( "password", Encode.string user.password )
                ]
          )
        ]


authUser : Model -> String -> Cmd Msg
authUser model apiUrl =
    { verb = "POST"
    , headers = [ ( "Content-Type", "application/json" ) ]
    , url = apiUrl
    , body = Http.jsonBody <| userEncoder model
    }
        |> Http.send CreateUser
