module Main exposing (..)

import Absences.Commands exposing (fetchAll)
import Messages exposing (Msg(..))
import Models exposing (Model, initialModel)
import Navigation exposing (Location)
import Routing exposing (Route)
import Update exposing (update)
import View exposing (view)
import Material


init : Location -> ( Model, Cmd Msg )
init location =
    let
        currentRoute =
            Routing.parseLocation location

    in
    ( initialModel currentRoute, Cmd.map AbsencesMsg fetchAll )


subscriptions : Model -> Sub Msg
subscriptions model =
    Material.subscriptions Mdl model

-- MAIN

main : Program Never Model Msg
main =
    Navigation.program OnLocationChange
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }