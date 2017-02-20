module Absences.Views.New exposing (view, header)

import Absences.Messages
import Absences.Models
import Dropdown
import Html exposing (Html, div, text, label, span)
import Layout.Header
import Material.Button as Button
import Material.Grid exposing (grid, size, cell, stretch, Device(..), offset)
import Material.Options as Options exposing (Style, onClick, onInput, css, onToggle)
import Material.Textfield as Textfield
import Material.Toggles as Toggles
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
    div
    []
    [ Options.div
          []
          [ text "kind" ]
    , Toggles.radio Mdl
          [ 0, 0, 0, 1]
          model.mdl
          [ Toggles.value ( "vacation" == absenceModel.newAbsence.kind )
          , Toggles.group "KindGroup"
          , Toggles.ripple
          , css "margin" "10px"
          , onToggle (AbsencesMsg <| (Absences.Messages.SelectKind "vacation"))
          ]
          [ text "Vacation" ]
    , Toggles.radio Mdl
          [ 0, 0, 0, 2]
          model.mdl
          [ Toggles.value ( "disease" == absenceModel.newAbsence.kind )
          , Toggles.group "KindGroup"
          , Toggles.ripple
          , css "margin" "10px"
          , onToggle (AbsencesMsg <| (Absences.Messages.SelectKind "disease"))
          ]
          [ text "Disease" ]
    , Toggles.radio Mdl
          [ 0, 0, 0, 3]
          model.mdl
          [ Toggles.value ( "special_leave" == absenceModel.newAbsence.kind )
          , Toggles.group "KindGroup"
          , Toggles.ripple
          , css "margin" "10px"
          , onToggle (AbsencesMsg <| (Absences.Messages.SelectKind "special_leave"))
          ]
          [ text "Special Leave" ]
    ]


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


cellOptions : List (Style a)
cellOptions =
    [ size All 12
    , stretch
    ]
