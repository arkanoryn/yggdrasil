module Users.Messages exposing (..)

import Http
import Users.Models exposing (UserId, User)


type Msg
    = Raise UserId
    | CreateUser (Result Http.Error User)
