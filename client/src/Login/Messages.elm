module Login.Messages exposing (..)

import Http
import Login.Models exposing (LoginForm)


type Msg
    = SetUsername String
    | SetPassword String
    | LogMeIn
    | OnAuth (Result Http.Error String)
