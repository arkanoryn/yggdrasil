module View exposing (view)

import Absences.Models exposing (AbsenceId)
import Absences.Views.List
import Absences.Views.New
import Absences.Views.Show
import Html exposing (Html, div, text, span)
import Html.Attributes exposing (style)
import Layout.Drawer as Drawer
import Layout.Header as Header
import Layout.SubMenu as SubMenu
import Login.Views.Form
import Material.Color as Color
import Material.Layout as Layout
import Material.Scheme as Scheme
import Messages exposing (Msg(..))
import Models exposing (Model)
import Routing exposing (Route(..))
import Users.Views.Index


view : Model -> Html Msg
view model =
    case model.loginModel.token of
        Nothing ->
            loginFormView model

        Just token ->
            loggedInView model


loginFormView : Model -> Html Msg
loginFormView model =
    Scheme.topWithScheme Color.Blue Color.LightBlue <|
        Layout.render Mdl
            model.mdl
            [ Layout.seamed
            ]
            { header = (Header.defaultHeader "Dashboard")
            , drawer = []
            , tabs = ([], [])
            , main =
                [ div
                    [ style [ ( "padding", "1rem" ) ] ]
                    [ Login.Views.Form.view model model.loginModel ]
                ]
            }

loggedInView : Model -> Html Msg
loggedInView model =
    Scheme.topWithScheme Color.Blue Color.LightBlue <|
        Layout.render Mdl
            model.mdl
            [ Layout.fixedHeader
            , Layout.fixedDrawer
            ]
            { header = (determineHeader model)
            , drawer = (Drawer.view model)
            , tabs = (SubMenu.view model)
            , main =
                [ div
                    [ style [ ( "padding", "1rem" ) ] ]
                    [ body model ]
                ]
            }


determineHeader : Model -> List (Html Msg)
determineHeader model =
    case model.route of
        AbsenceNew ->
            Absences.Views.New.header model

        AbsenceIndex ->
            Absences.Views.List.header model

        _ ->
            Header.defaultHeader "Header undefined!!"


body : Model -> Html Msg
body model =
    let
        _ =
            Debug.log "route:" model.route
    in
        case model.route of
            Home ->
                div [] [ text "Home" ]

            AbsenceNew ->
                Absences.Views.New.view model model.absenceModel

            AbsenceIndex ->
                Absences.Views.List.view model model.absenceModel.absences

            AbsenceShow id ->
                absenceShowPage model id

            UsersIndex ->
                Users.Views.Index.view model

            NotFound ->
                notFoundView


absenceShowPage : Model -> AbsenceId -> Html Msg
absenceShowPage model absenceId =
    let
        maybeAbsence =
            model.absenceModel.absences
                |> List.filter (\absence -> absence.id == absenceId)
                |> List.head
    in
        case maybeAbsence of
            Just absence ->
                Html.map AbsencesMsg (Absences.Views.Show.view absence)

            Nothing ->
                notFoundView


notFoundView : Html msg
notFoundView =
    div []
        [ text "404 - Not found!"
        ]
