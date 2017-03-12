port module Main exposing (..)

import Material
import Messages exposing (Msg(..))
import Models exposing (Flags, Model, initialModel)
import Navigation exposing (Location)
import Ports exposing (retrieve, mapStorage)
import Routing exposing (Route)
import Update exposing (update)
import View exposing (view)


init : Flags -> Location -> ( Model, Cmd Msg )
init flags location =
    let
        currentRoute =
            Routing.parseLocation location

        model =
            initialModel currentRoute
    in
        model ! []


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ Material.subscriptions Mdl model
        , retrieve mapStorage
        ]



-- MAIN


main : Program Flags Model Msg
main =
    Navigation.programWithFlags NewLocation
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
