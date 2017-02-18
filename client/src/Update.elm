module Update exposing (..)

import Absences.Update
import Material
import Messages exposing (Msg(..))
import Models exposing (Model)
import Navigation exposing (..)
import Routing exposing (parseLocation, pageToUrl)
import Users.Update


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Mdl msg_ ->
            Material.update Mdl msg_ model

        AbsencesMsg absenceMsg ->
            let
                ( absenceModel, cmd ) =
                    Absences.Update.update model absenceMsg model.absenceModel
            in
                ( { model | absenceModel = absenceModel }, Cmd.map AbsencesMsg cmd )

        UsersMsg userMsg ->
            let
                ( userModel, cmd ) =
                    Users.Update.update model userMsg model.userModel
            in
                ( { model | userModel = userModel }, Cmd.map UsersMsg cmd )

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
                    { model | route = page } ! [ Navigation.newUrl (Routing.pageToUrl page) ]
