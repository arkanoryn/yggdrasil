module View exposing (..)

import Absences.Models exposing (AbsenceId)
import Absences.Views.Edit
import Absences.Views.List
import Html exposing (Html, div, text, span)
import Html.Attributes exposing (style)
import Material.Color as Color
import Material.Layout as Layout
import Material.List as List
import Material.Options as Options exposing (when)
import Material.Scheme as Scheme
import Messages exposing (Msg(..))
import Models exposing (Model)
import Routing exposing (Route(..))

view : Model -> Html Msg
view model =
    Scheme.topWithScheme Color.Indigo Color.DeepOrange <|
        Layout.render Mdl model.mdl
            [ Layout.fixedHeader
            , Layout.fixedDrawer
            ]
        { header = [ viewHeader model ]
        , drawer = [ viewDrawer model ]
        , tabs = (tabTitles, [  ])
        , main =
              [ div
                [ style [ ( "padding", "1rem" ) ] ]
                [ page model ]
              ]
    }


tabs : List (String, String, Model -> Html Msg)
tabs =
    [ ("Absence", "absence", .absences >> Absences.Views.List.view >> Html.map AbsencesMsg)
    ]


tabTitles : List (Html a)
tabTitles =
  List.map (\(x,_,_) -> text x) tabs

viewHeader : Model -> Html Msg
viewHeader model =
    Layout.row
        []
        [ Layout.title [] [ text "Vacations" ]
        , Layout.spacer
        , Layout.navigation []
            [ Layout.link
                [ Layout.href "https://github.com/arkanoryn/yggdrasil" ]
                [ span [] [ text "github" ] ]
            ]
        ]


type alias MenuItem =
    { text : String
    , iconName : String
    }


menuItems : List MenuItem
menuItems =
    [ { text = "Dashboard", iconName = "dashboard" }
    , { text = "Absences", iconName = "flight_takeoff" }
    ]


viewDrawerMenuItem : Model -> MenuItem -> Html Msg
viewDrawerMenuItem model menuItem =
    List.li
        [ Options.css "cursor" "pointer"
        -- , Options.attribute <| onClick (NavigateTo menuItem.route)
        -- , Color.text Color.accent `when` (model.route == menuItem.route)
        ]
        [ List.content
            []
            [ List.icon menuItem.iconName []
            , text menuItem.text
            ]
        ]


viewDrawer : Model -> Html Msg
viewDrawer model =
    List.ul
        []
        (List.map (viewDrawerMenuItem model) menuItems)


page : Model -> Html Msg
page model =
    case model.route of
        AbsencesRoute ->
            Html.map AbsencesMsg (Absences.Views.List.view model.absences)

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
