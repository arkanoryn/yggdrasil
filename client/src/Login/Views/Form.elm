module Login.Views.Form exposing (view)

import Html exposing (Html, div, text, span)
import Login.Messages
import Login.Models
import Material.Button as Button
import Material.Grid exposing (grid, size, cell, stretch, Device(..), offset)
import Material.Options exposing (Style, onClick, onInput, css)
import Material.Textfield as Textfield
import Messages exposing (Msg(..))
import Models exposing (Model)


view : Model -> Login.Models.Model -> Html Msg
view model loginModel =
    grid []
        [ cell cellOptions [ usernameField model loginModel ]
        , cell cellOptions [ passwordField model loginModel ]
        , cell cellOptions [ submitButton model loginModel ]
        ]


usernameField : Model -> Login.Models.Model -> Html Msg
usernameField model loginModel =
    Textfield.render Mdl
        [ 0, 0, 0 ]
        model.mdl
        [ Textfield.label "username"
        , Textfield.floatingLabel
        , Textfield.text_
        , css "width" "100%"
        , Textfield.value loginModel.loginForm.username
        , onInput (LoginMsg << Login.Messages.SetUsername)
        ]
        []


passwordField : Model -> Login.Models.Model -> Html Msg
passwordField model loginModel =
    Textfield.render Mdl
        [ 0, 0, 1 ]
        model.mdl
        [ Textfield.label "password"
        , Textfield.floatingLabel
        , Textfield.password
        , css "width" "100%"
        , Textfield.value loginModel.loginForm.password
        , onInput (LoginMsg << Login.Messages.SetPassword)
        ]
        []


submitButton : Model -> Login.Models.Model -> Html Msg
submitButton model loginModel =
    Button.render Mdl
        [ 1, 2, 3 ]
        model.mdl
        [ Button.raised
        , Button.ripple
        , Button.colored
        , css "width" "100%"
        , onClick (LoginMsg Login.Messages.LogMeIn)
        ]
        [ text "Submit" ]


cellOptions : List (Style a)
cellOptions =
    [ size Desktop 4
    , offset Desktop 4
    , size Tablet 8
    , offset Tablet 2
    , size Phone 12
    , stretch
    ]
