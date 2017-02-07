module Absences.Views.New exposing (view)

import Html exposing (Html, div, text, label)
import Messages exposing (Msg(..))
import Models exposing (Model)
import Material.Button as Button
import Material.Options as Options exposing (onClick)
import Material.Textfield as Textfield
import Material.Grid exposing (grid, size, cell, Device(..))
import Dropdown
import Absences.Messages
import Absences.Models
import Form exposing (Form)


view : Model -> Absences.Models.Model -> Html Msg
view model absenceModel =
    grid []
        [ cell [ size All 12 ]
            [ kindField absenceModel ]
        , cell [ size All 6 ]
            [ text "begin_on" ]
        , cell [ size All 12 ]
            [ submitButton model absenceModel ]
        ]

kindField : Absences.Models.Model -> Html Msg
kindField absenceModel =
    div []
        [ label []
            [ text "Kind: "
            , Dropdown.dropdown
                kindDropdownOptions
                []
                absenceModel.selectedKind
            ]
        ]


submitButton : Model -> Absences.Models.Model -> Html Msg
submitButton model absenceModel =
    Button.render Mdl
        [ 1, 2 ]
        model.mdl
        [ Button.raised
        , Button.ripple
        , Button.colored
        , Options.onClick <| tagged Form.Submit
        ]
        [ text "Submit" ]


kindDropdownOptions : Dropdown.Options Msg
kindDropdownOptions =
    let
        kindOptions =
            Dropdown.defaultOptions (AbsencesMsg Absences.Messages.KindDropdownChanged )
    in
        { kindOptions
            | items =
                [ { value = "vacation", text = "Vacation", enabled = True }
                , { value = "disease", text = "Disease", enabled = True }
                , { value = "special_leave", text = "Special leave", enabled = True }
                ]
            , emptyItem = Nothing
        }


tagged : Form.Msg -> Msg
tagged =
    AbsencesMsg << Absences.Messages.NewAbsenceFormMsg
