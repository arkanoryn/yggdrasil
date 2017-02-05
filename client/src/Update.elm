module Update exposing (..)

import Absences.Update
import Material
import Messages exposing (Msg(..))
import Models exposing (Model)
import Routing exposing (parseLocation)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Mdl msg_ ->
            Material.update Mdl msg_ model

        AbsencesMsg subMsg ->
            let
                ( updatedAbsences, cmd ) =
                    Absences.Update.update subMsg model.absences
            in
                ( { model | absences = updatedAbsences }, Cmd.map AbsencesMsg cmd )


        OnLocationChange location ->
            let
                newRoute =
                    parseLocation location

            in
                ( { model | route = newRoute } ! [] )
