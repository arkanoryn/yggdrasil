module Users.Update exposing (update)

import Users.Models as UserMod
import Users.Messages exposing (Msg(..))
import Models exposing (Model)

update : Model -> Msg -> (UserMod.Model, Cmd Msg)
update model msg =
    case msg of
        CreateUser res ->
            model.userModel ! []
