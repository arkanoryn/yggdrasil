module Users.Update exposing (update)

import Users.Models as UserMod
import Users.Messages exposing (Msg(..))
import Models exposing (Model)


update : Model -> Msg -> UserMod.Model -> ( UserMod.Model, Cmd Msg )
update model msg userModel =
    case msg of
        Raise id ->
            { userModel | raised = id } ! []

        CreateUser res ->
            model.userModel ! []
