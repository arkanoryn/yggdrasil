module Absences.Update exposing (..)

import Messages
import Absences.Messages exposing (Msg(..))
import Absences.Models exposing (Model, Absence, validation)
import Navigation
import Form
import Form.Validate as Validate exposing (..)
import Form.Input as Input
import Absences.Commands as API


update : Msg -> Absences.Models.Model -> ( Absences.Models.Model, Cmd Msg )
update msg absenceModel =
    case msg of
        OnFetchAll (Ok newAbsences) ->
            { absenceModel | absences = newAbsences } ! []

        OnFetchAll (Err error) ->
            absenceModel ! []

        CreateAbsence ->
            absenceModel ! []

        CreateAbsenceSucceeded _ ->
            absenceModel ! []

        CreateAbsenceFailed error ->
            absenceModel ! []

        ShowAbsences ->
            ( absenceModel, Navigation.newUrl "#absences" )

        ShowAbsence id ->
            ( absenceModel, Navigation.newUrl ("#absences/" ++ id) )

        KindDropdownChanged selectedValue ->
            let
                oldNewAbsence =
                    absenceModel.newAbsence
                cleanValue =
                    case selectedValue of
                        Just value ->
                            value
                        Nothing ->
                            ""
            in
                { absenceModel | newAbsence =
                      { oldNewAbsence | kind = cleanValue }
                }
                    ! []

        NewAbsenceFormMsg formMsg ->
            ( { absenceModel | newAbsence = Form.update validation formMsg form }, Cmd.none )
