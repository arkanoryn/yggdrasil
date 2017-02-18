module Users.Messages exposing (..)

import Users.Models exposing (UserId, User)
import Http

type Msg
    = CreateUser (Result Http.Error User)
