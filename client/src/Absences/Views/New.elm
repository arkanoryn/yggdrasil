module Absences.Views.New exposing (view, header)

import Absences.Messages
import Absences.Models
import Html exposing (Html, div, text, label)
import Layout.Header
import Material.Button as Button
import Material.Grid exposing (grid, size, cell, stretch, Device(..), offset)
import Material.Options exposing (Style, onClick, onInput, css)
import Material.Textfield as Textfield
import Messages exposing (Msg(..))
import Models exposing (Model)


header : Model -> List (Html Msg)
header model =
    Layout.Header.defaultHeader "New absence"


view : Model -> Absences.Models.Model -> Html Msg
view model absenceModel =
    grid []
        [ cell cellOptions [ kindField model absenceModel ]
        , cell [ size All 6 ] [ beginOnField model absenceModel ]
        , cell [ size All 6 ] [ endOnField model absenceModel ]
        , cell [ size All 2 ] [ submitButton model absenceModel ]
        ]


kindField : Model -> Absences.Models.Model -> Html Msg
kindField model absenceModel =
    Textfield.render Mdl
        [ 0, 0, 0 ]
        model.mdl
        [ Textfield.label "kind"
        , Textfield.floatingLabel
        , Textfield.text_
        , css "width" "100%"
        , Textfield.value absenceModel.newAbsence.kind
        , onInput (AbsencesMsg << Absences.Messages.ChangeKind)
        ]
        []


beginOnField : Model -> Absences.Models.Model -> Html Msg
beginOnField model absenceModel =
    Textfield.render Mdl
        [ 0, 0, 1 ]
        model.mdl
        [ Textfield.label "begin_on"
        , Textfield.floatingLabel
        , Textfield.text_
        , css "width" "100%"
        , Textfield.value absenceModel.newAbsence.begin_on
        , onInput (AbsencesMsg << Absences.Messages.ChangeBeginOn)
        ]
        []


endOnField : Model -> Absences.Models.Model -> Html Msg
endOnField model absenceModel =
    Textfield.render Mdl
        [ 0, 0, 2 ]
        model.mdl
        [ Textfield.label "end_on"
        , Textfield.floatingLabel
        , Textfield.text_
        , css "width" "100%"
        , Textfield.value absenceModel.newAbsence.end_on
        , onInput (AbsencesMsg << Absences.Messages.ChangeEndOn)
        ]
        []


submitButton : Model -> Absences.Models.Model -> Html Msg
submitButton model absenceModel =
    Button.render Mdl
        [ 1, 2, 3 ]
        model.mdl
        [ Button.raised
        , Button.ripple
        , Button.colored
        , css "width" "100%"
        , onClick (AbsencesMsg Absences.Messages.CreateAbsence)
        ]
        [ text "Submit" ]


kindDropdownOptions : Html Msg
kindDropdownOptions =
    div [] []



--     let
--         kindOptions =
--             Dropdown.defaultOptions (AbsencesMsg Absences.Messages.KindDropdownChanged )
--     in
--         { kindOptions
--             | items =
--                 [ { value = "vacation", text = "Vacation", enabled = True }
--                 , { value = "disease", text = "Disease", enabled = True }
--                 , { value = "special_leave", text = "Special leave", enabled = True }
--                 ]
--             , emptyItem = Nothing
--         }
-- tagged : Form.Msg -> Msg
-- tagged =
--     AbsencesMsg << Absences.Messages.NewAbsenceFormMsg


cellOptions : List (Style a)
cellOptions =
    [ size All 12
    , stretch
    ]
