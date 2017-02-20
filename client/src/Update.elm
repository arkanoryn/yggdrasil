module Update exposing (..)

import Absences.Commands as AbsencesAPI
import Absences.Messages
import Absences.Update
import Login.Update
import Material
import Messages exposing (Msg(..))
import Models exposing (Model)
import Navigation exposing (..)
import Routing exposing (parseLocation, pageToUrl, Route(..))
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

        LoginMsg loginMsg ->
            let
                ( loginModel, cmd ) =
                    Login.Update.update model loginMsg model.loginModel
            in
                ( { model | loginModel = loginModel }, Cmd.map LoginMsg cmd )

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

                Just AbsenceIndex ->
                    { model | route = AbsenceIndex } ! [ Cmd.batch [(Navigation.newUrl "#absences"), Cmd.map AbsencesMsg (AbsencesAPI.fetchAll model)] ]

                Just page ->
                    { model | route = page } ! [ Navigation.newUrl (Routing.pageToUrl page) ]
