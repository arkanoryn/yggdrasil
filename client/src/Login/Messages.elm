module Login.Messages exposing (..)

import Login.Models exposing (LoginForm)
import Http

type Msg
    = SetUsername String
    | SetPassword String
    | LogMeIn
    | OnAuth (Result Http.Error String)
