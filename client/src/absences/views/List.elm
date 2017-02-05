module Absences.Views.List exposing (..)

import Absences.Messages exposing (..)
import Absences.Models exposing (Absence)
import Html exposing (..)
import Html.Attributes exposing (class)
import Html.Events exposing (onClick)
import Material.Button as Button
import Material.Options as Options exposing (onClick)
import Material
import Material.Icon as Icon
import Material.Table as Table
import Models exposing (Model)


view : List Absence -> Html Msg
view absences =
    div []
        [ pageHeader absences
        , absenceTable absences
        ]


pageHeader : List Absence -> Html Msg
pageHeader absences =
    div [ ]
         -- addAbsenceButton model
        []


absenceTable : List Absence -> Html Msg
absenceTable absences =
    div [ ]
        [ Table.table []
              [ Table.thead []
                    [ Table.tr []
                          [ Table.th [] [ text "Id" ]
                          , Table.th [ ] [ text "Kind" ]
                          , Table.th [ ] [ text "Status" ]
                          , Table.th [ ] [ text "Begin on" ]
                          , Table.th [ ] [ text "End on" ]
                          , Table.th [ ] [ text "Actions" ]
                          ]
                    ]
              , Table.tbody [] (absences |> List.map absenceRow)
              ]
        ]


absenceRow : Absence -> Html Msg
absenceRow absence =
    Table.tr []
        [ Table.td [ ] [ text absence.id ]
        , Table.td [ ] [ text absence.kind ]
        , Table.td [ ] [ text absence.status ]
        , Table.td [ ] [ text absence.begin_on ]
        , Table.td [ ] [ text absence.end_on ]
        , Table.td [ ] [ editBtn absence ]
        ]



editBtn : Absence -> Html Msg
editBtn absence =
    button [ class "btn regular"
           ,  Html.Events.onClick (ShowAbsence absence.id)
           ]
    [ i [ class "fa fa-pencil mr1" ] []
    , text "Edit"
    ]

-- addAbsenceButton : Model -> Html Msg
-- addAbsenceButton model =
--     Button.render Mdl [9, 0, 0, 1] model.mdl
--         [ Button.ripple
--         , Button.colored
--         , Options.onClick ShowAbsences
--         ]
--         [ "add" ]
