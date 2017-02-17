module Layout.Drawer exposing (view)

import Html exposing (Html, div, text, span)
import Material.Color as Color
import Material.List as List
import Material.Options as Options exposing (when, onClick)
import Messages exposing (Msg(..))
import Models exposing (Model)
import Routing exposing (..)


view : Model -> List (Html Msg)
view model =
    [ view_ model ]


view_ : Model -> Html Msg
view_ model =
    List.ul
        []
        (List.map (viewMenuItem model) menuItems)


viewMenuItem : Model -> MenuItem -> Html Msg
viewMenuItem model menuItem =
    List.li
        [ Options.css "cursor" "pointer"
        , Options.onClick (NavigateTo menuItem.route)
        , Color.text Color.accent |> when (Just model.route == menuItem.route)
        ]
        [ List.content
            []
            [ List.icon menuItem.iconName []
            , text menuItem.text
            ]
        ]


type alias MenuItem =
    { text :     String
    , iconName : String
    , route :    Maybe Routing.Route
    }


menuItems : List MenuItem
menuItems =
    [ { text = "Dashboard",     iconName = "dashboard",      route = (Just Home) }
    , { text = "Absences",      iconName = "flight_takeoff", route = (Just AbsenceIndex) }
    , { text = "Last Activity", iconName = "alarm",          route = Nothing }
    , { text = "Timesheets",    iconName = "event",          route = Nothing }
    , { text = "Reports",       iconName = "list",           route = Nothing }
    , { text = "Organizations", iconName = "store",          route = Nothing }
    , { text = "Project",       iconName = "view_list",      route = Nothing }
    ]
