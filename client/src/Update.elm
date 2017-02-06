module Update exposing (..)

import Absences.Update
import Material
import Messages exposing (Msg(..))
import Models exposing (Model)
import Navigation exposing (..)
import Routing exposing (parseLocation, pageToUrl)


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
