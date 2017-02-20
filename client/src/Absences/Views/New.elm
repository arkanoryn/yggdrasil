module Absences.Views.New exposing (view, header)

import Absences.Messages
import Absences.Models exposing (DateField(..))
import Date exposing (Date, Month(..))
import Date.Extra as Date exposing (Interval(Year, Month, Day))
import DateSelectorDropdown
import Html exposing (Html, div, text, label, span)
import Layout.Header
import Material.Button as Button
import Material.Grid exposing (grid, size, cell, stretch, Device(..), offset)
import Material.Options as Options exposing (Style, onClick, onInput, css, onToggle)
import Material.Toggles as Toggles
import Messages exposing (Msg(..))
import Models exposing (Model)
import Time exposing (Time)


header : Model -> List (Html Msg)
header model =
    Layout.Header.defaultHeader "New absence"


view : Model -> Absences.Models.Model -> Html Msg
view model absenceModel =
    grid []
        [ cell cellOptions [ kindField model absenceModel ]
        , cell cellOptions [ beginOnDateSelector model absenceModel today
                           , endOnDateSelector model absenceModel today
                           ]
        , cell
              [ size All 2
              , offset Desktop 4
              , offset Tablet 2
              ]
              [ submitButton model absenceModel ]
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
    div [] []


endOnField : Model -> Absences.Models.Model -> Html Msg
endOnField model absenceModel =
    div [] []



beginOnDateSelector : Model -> Absences.Models.Model -> Date -> Html Msg
beginOnDateSelector model absenceModel today =
    div []
        [ Html.node "style"
              []
              [ text <|
                    String.join " "
                    [ "@import url(./css/example.css);"
                    , "@import url(./css/date_selector.css);"
                    ]
              ]
        , div []
            [ div []
                  [ label [] [ text ("From: " ++ absenceModel.newAbsence.begin_on) ]
                  , Html.map AbsencesMsg <| (viewDateSelector BeginOn
                                                 absenceModel.openDateField
                                                 today
                                                 (Date.add Year 1 today)
                                                 (Just absenceModel.begin_on_tmp))
                  ]
            ]
        ]

endOnDateSelector : Model -> Absences.Models.Model -> Date -> Html Msg
endOnDateSelector model absenceModel today =
    let
        begin_date =
            case (Date.fromIsoString absenceModel.newAbsence.begin_on) of
                Just date ->
                    date

                Nothing ->
                    today
    in
        div []
            [ div []
                  [ label [] [ text ("To: " ++ absenceModel.newAbsence.end_on) ]
                  , Html.map AbsencesMsg <| (viewDateSelector EndOn
                                                 absenceModel.openDateField
                                                 begin_date
                                                 (Date.add Year 5 begin_date)
                                                 (Just absenceModel.end_on_tmp))
                  ]
            ]


viewDateSelector : DateField -> Maybe DateField -> Date -> Date -> Maybe Date -> Html Absences.Messages.Msg
viewDateSelector dateField openDateField =
    let
        isOpen =
            openDateField |> Maybe.map ((==) dateField) |> Maybe.withDefault False
    in
        DateSelectorDropdown.view
            (if isOpen then
                 (Absences.Messages.CloseDropdown)
             else
                 (Absences.Messages.OpenDropdown dateField))
            (Absences.Messages.SelectDate dateField)
            isOpen

submitButton : Model -> Absences.Models.Model -> Html Msg
submitButton model absenceModel =
    Button.render Mdl
        [ 1, 2, 3 ]
        model.mdl
        [ Button.raised
        , Button.ripple
        , Button.colored
        , css "width" "100%"
        , css "margin-top" "10px"
        , onClick (AbsencesMsg Absences.Messages.CreateAbsence)
        ]
        [ text "Submit" ]


cellOptions : List (Style a)
cellOptions =
    [ size Phone 12
    , size Desktop 6
    , size Tablet 8
    , offset Desktop 3
    , offset Tablet 2
    , stretch
    ]


today : Date
today =
    (Date.fromCalendarDate 2017 Jan 01)
