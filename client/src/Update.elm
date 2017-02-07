module Update exposing (..)

import Absences.Update
import Material
import Absences.Messages as AbsencesMsg
import Absences.Models as AbsencesModels
import Messages exposing (Msg(..))
import Models exposing (Model)
import Navigation exposing (..)
import Routing exposing (parseLocation, pageToUrl)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Mdl msg_ ->
            Material.update Mdl msg_ model

        AbsencesMsg absenceMsg ->
            let
                ( absenceModel, cmd ) =
                    Absences.Update.update absenceMsg model.absenceModel
            in
                ( { model | absenceModel = absenceModel }, Cmd.map AbsencesMsg cmd )

        NewLocation location ->
            let
                newRoute =
                    parseLocation location
            in
                ({ model | route = newRoute } ! [])

        NavigateTo maybePage ->
            case maybePage of
                Nothing ->
                    model ! []

                Just page ->
                    model ! [ Navigation.newUrl (Routing.pageToUrl page) ]
