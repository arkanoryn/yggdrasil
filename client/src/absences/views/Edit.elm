module Absences.Views.Edit exposing (..)

import Absences.Messages exposing (..)
import Absences.Models exposing (..)
import Html exposing (..)
import Html.Attributes exposing (class, value, href)
import Html.Events exposing (onClick)

view : Absence -> Html Msg
view model =
    div []
        [ nav model
        , form model
        , backBtn
        ]


nav : Absence -> Html Msg
nav model =
    div [ class "clearfix mb2 white bg-black p1" ]
        []


form : Absence -> Html Msg
form absence =
    div [ class "m3" ]
        [ h1 [] [ text absence.kind ]
        , formStatus absence
        ]


formStatus : Absence -> Html Msg
formStatus absence =
    div
        [ class "clearfix py1"
        ]
        [ div [ class "col col-5" ] [ text "Status" ]
        , div [ class "col col-7" ]
            [ span [ class "h2 bold" ] [ text (toString absence.status) ]
            ]
        ]


backBtn : Html Msg
backBtn =
    button [ class "btn regular"
           , onClick (ShowAbsences)
           ]
        [ i [ class "fa fa-pencil mr1" ] []
        , text "Back"
        ]
