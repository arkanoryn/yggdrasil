module Absences.Views.List exposing (view, header)

import Absences.Models exposing (Absence)
import Html exposing (..)
import Layout.Header
import Material.Button as Button
import Material.Icon as Icon
import Material.Options as Options exposing (onClick, css)
import Material.Table as Table
import Messages exposing (..)
import Models exposing (Model)
import Routing exposing (Route(..))


header : Model -> List (Html Msg)
header model =
    Layout.Header.defaultHeaderWithNavigation
        "Absences"
        [ addAbsenceButton model
        ]


view : Model -> List Absence -> Html Msg
view model absences =
    div []
        [ absenceTable model absences
        ]


absenceTable : Model -> List Absence -> Html Msg
absenceTable model absences =
    div []
        [ Table.table []
            [ Table.thead []
                [ Table.tr []
                    [ Table.th [] [ text "Id" ]
                    , Table.th [] [ text "Kind" ]
                    , Table.th [] [ text "Status" ]
                    , Table.th [] [ text "Begin on" ]
                    , Table.th [] [ text "End on" ]
                    , Table.th [] [ text "Actions" ]
                    ]
                ]
            , Table.tbody []
                (List.indexedMap (viewAbsenceRow model) absences)
            ]
        ]


viewAbsenceRow : Model -> Int -> Absence -> Html Msg
viewAbsenceRow model index absence =
    Table.tr []
        [ Table.td [] [ text absence.id ]
        , Table.td [] [ text absence.kind ]
        , Table.td [] [ text absence.status ]
        , Table.td [] [ text absence.begin_on ]
        , Table.td [] [ text absence.end_on ]
        , Table.td [] [ viewShowBtn model index absence ]
        ]


viewShowBtn : Model -> Int -> Absence -> Html Msg
viewShowBtn model index absence =
    Button.render Mdl
        [ 0, 1, index ]
        model.mdl
        [ Button.minifab
        , Button.colored
        , Button.ripple
        , Options.onClick <| NavigateTo <| Just (AbsenceShow absence.id)
        ]
        [ Icon.i "pageview" ]


addAbsenceButton : Model -> Html Msg
addAbsenceButton model =
    Button.render Mdl
        [ 0 ]
        model.mdl
        [ css "position" "fixed"
        , css "display" "block"
        , css "right" "0"
        , css "top" "0"
        , css "margin-right" "35px"
        , css "margin-top" "35px"
        , css "z-index" "900"
        , Button.fab
        , Button.colored
        , Button.ripple
        , Options.onClick <| NavigateTo <| Just AbsenceNew
        ]
        [ Icon.i "add" ]
