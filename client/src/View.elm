module View exposing (view)

import Absences.Models exposing (AbsenceId)
import Absences.Views.Edit
import Absences.Views.List
import Html exposing (Html, div, text, span)
import Html.Attributes exposing (style)
import Layout.Drawer as Drawer
import Layout.Header as Header
import Layout.SubMenu as SubMenu
import Material.Color as Color
import Material.Layout as Layout
import Material.Scheme as Scheme
import Messages exposing (Msg(..))
import Models exposing (Model)
import Routing exposing (Route(..))


view : Model -> Html Msg
view model =
    Scheme.topWithScheme Color.Indigo Color.DeepOrange <|
        Layout.render Mdl
            model.mdl
            [ Layout.fixedHeader
            , Layout.fixedDrawer
            ]
            { header = (Header.view model)
            , drawer = (Drawer.view model)
            , tabs = (SubMenu.view model)
            , main =
                [ div
                    [ style [ ( "padding", "1rem" ) ] ]
                    [ pageContent model ]
                ]
            }


pageContent : Model -> Html Msg
pageContent model =
    case model.route of
        HomeRoute ->
            div [] [ text "Home" ]

        AbsencesRoute ->
            Absences.Views.List.view model model.absences

        AbsenceRoute id ->
            absenceEditPage model id

        NotFoundRoute ->
            notFoundView


absenceEditPage : Model -> AbsenceId -> Html Msg
absenceEditPage model absenceId =
    let
        maybeAbsence =
            model.absences
                |> List.filter (\absence -> absence.id == absenceId)
                |> List.head
    in
        case maybeAbsence of
            Just absence ->
                Html.map AbsencesMsg (Absences.Views.Edit.view absence)

            Nothing ->
                notFoundView


notFoundView : Html msg
notFoundView =
    div []
        [ text "Not found"
        ]
