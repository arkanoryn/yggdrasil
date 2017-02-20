module Login.Update exposing (update)

import Login.Commands as API
import Login.Messages exposing (Msg(..))
import Login.Models exposing (initLoginForm)
import Models exposing (Model)


update : Model -> Login.Messages.Msg -> Login.Models.Model -> (Login.Models.Model, Cmd Msg)
update model msg loginModel =
    case msg of
        SetUsername str ->
            let
                form = loginModel.loginForm
            in
            { loginModel | loginForm = { form | username = str } } ! []

        SetPassword str ->
            let
                form = loginModel.loginForm
            in
            { loginModel | loginForm = { form | password = str } } ! []

        LogMeIn ->
            loginModel ! [ API.authMe model loginModel.loginForm ]


        OnAuth (Ok token) ->
            { loginModel
                | token = Just token
                , loginForm = initLoginForm
            } ! []
            -- Redirect to Home would be great

        OnAuth (Err error) ->
            let
                _ = Debug.log "Auth failed: " error
            in
                loginModel ! []
