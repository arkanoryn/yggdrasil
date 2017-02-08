module Absences.Views.New exposing (view)

import Html exposing (Html, div, text, label)
import Messages exposing (Msg(..))
import Models exposing (Model)
import Material.Button as Button
import Material.Options as Options exposing (onClick)
import Material.Textfield as Textfield
import Material.Grid exposing (grid, size, cell, Device(..))
import Absences.Messages
import Absences.Models
import Routing exposing (Route(..))


view : Model -> Absences.Models.Model -> Html Msg
view model absenceModel =
    grid []
        [ cell [ size All 12 ]
            [ kindField model absenceModel ]
          , cell [ size All 6 ]
              [ beginOnField model absenceModel ]
          , cell [ size All 6 ]
              [ endOnField model absenceModel ]
        , cell [ size All 12 ]
            [ submitButton model absenceModel ]
        ]


kindField : Model -> Absences.Models.Model -> Html Msg
kindField model absenceModel =
    Textfield.render Mdl
        [ 1, 2, 0 ]
        model.mdl
        [ Textfield.label "kind"
        , Textfield.text_
        , Textfield.value absenceModel.newAbsence.kind
        , Options.onInput (AbsencesMsg << Absences.Messages.ChangeKind)
        ]
        []


beginOnField : Model -> Absences.Models.Model -> Html Msg
beginOnField model absenceModel =
    Textfield.render Mdl
        [ 1, 2, 0 ]
        model.mdl
        [ Textfield.label "begin_on"
        , Textfield.text_
        , Textfield.value absenceModel.newAbsence.begin_on
        , Options.onInput (AbsencesMsg << Absences.Messages.ChangeBeginOn)
        ]
        []


endOnField : Model -> Absences.Models.Model -> Html Msg
endOnField model absenceModel =
    Textfield.render Mdl
        [ 1, 2, 0 ]
        model.mdl
        [ Textfield.label "end_on"
        , Textfield.text_
        , Textfield.value absenceModel.newAbsence.end_on
        , Options.onInput (AbsencesMsg << Absences.Messages.ChangeEndOn)
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
        , Options.onClick (AbsencesMsg Absences.Messages.CreateAbsence)
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
