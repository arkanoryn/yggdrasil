module Main exposing (..)

import Material
import Messages exposing (Msg(..))
import Models exposing (Model, initialModel)
import Navigation exposing (Location)
import Routing exposing (Route)
import Update exposing (update)
import View exposing (view)


init : Location -> ( Model, Cmd Msg )
init location =
    let
        currentRoute =
            Routing.parseLocation location

        model =
            initialModel currentRoute
    in
        model ! []


subscriptions : Model -> Sub Msg
subscriptions model =
    Material.subscriptions Mdl model



-- MAIN


main : Program Never Model Msg
main =
    Navigation.program NewLocation
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
