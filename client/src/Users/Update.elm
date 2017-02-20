module Users.Update exposing (update)

import Models exposing (Model)
import Users.Messages exposing (Msg(..))
import Users.Models as UserMod


update : Model -> Msg -> UserMod.Model -> ( UserMod.Model, Cmd Msg )
update model msg userModel =
    case msg of
        Raise id ->
            { userModel | raised = id } ! []

        CreateUser res ->
            model.userModel ! []
