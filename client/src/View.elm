module View exposing (view)

import Absences.Models exposing (AbsenceId)
import Absences.Views.Show
import Absences.Views.List
import Absences.Views.New
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

        NewAbsenceRoute ->
            Absences.Views.New.view model model.absenceModel

        AbsencesRoute ->
            Absences.Views.List.view model model.absenceModel.absences

        AbsenceRoute id ->
            absenceShowPage model id

        NotFoundRoute ->
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
                absenceNotFoundView


notFoundView : Html msg
notFoundView =
    div []
        [ text "404 - Not found!"
        ]


absenceNotFoundView : Html msg
absenceNotFoundView =
    div []
        [ text "Absence not found!"
        ]
