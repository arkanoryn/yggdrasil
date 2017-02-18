module Users.Messages exposing (..)

import Users.Models exposing (UserId, User)
import Http


type Msg
    = Raise UserId
    | CreateUser (Result Http.Error User)
