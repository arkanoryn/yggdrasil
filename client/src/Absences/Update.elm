module Absences.Update exposing (..)

import Absences.Commands as API
import Absences.Messages exposing (Msg(..))
import Absences.Models exposing (Absence, DateField(..))
import Date exposing (Date)
import Date.Extra as Date
import Models exposing (Model)
import Navigation


update : Model -> Msg -> Absences.Models.Model -> ( Absences.Models.Model, Cmd Msg )
update model msg absenceModel =
    case msg of
        OnFetchAll (Ok newAbsences) ->
            { absenceModel | absences = newAbsences } ! []

        OnFetchAll (Err error) ->
            let
                _ =
                    Debug.log "fetch" error
            in
                absenceModel ! []

        OnCreate (Ok newAbsence) ->
            let
                _ =
                    Debug.log "Create absence successful: " newAbsence

                newAbsencesList =
                    absenceModel.absences ++ [ newAbsence ]
            in
                { absenceModel
                    | newAbsence = Absences.Models.initAbsence
                    , absences = newAbsencesList
                }
                    ! [ Navigation.newUrl "#absences" ]

        OnCreate (Err error) ->
            let
                _ =
                    Debug.log "Create absence failed: " error
            in
                absenceModel ! []

        CreateAbsence ->
            absenceModel ! [ API.create model absenceModel.newAbsence ]

        ShowAbsences ->
            absenceModel ! [ (API.fetchAll model) ]

        ShowAbsence id ->
            absenceModel ! [ Navigation.newUrl ("#absences/" ++ id) ]

        SelectKind newKind ->
            let
                oldNewAbsence =
                    absenceModel.newAbsence
            in
                { absenceModel
                    | newAbsence = { oldNewAbsence | kind = newKind }
                }
                    ! []

        OpenDropdown dateField ->
            { absenceModel | openDateField = Just dateField } ! []

        CloseDropdown ->
            { absenceModel | openDateField = Nothing } ! []

        SelectDate dateField date ->
            case dateField of
                BeginOn ->
                    let
                        oldNewAbsence =
                            absenceModel.newAbsence
                    in
                        { absenceModel
                            | newAbsence = { oldNewAbsence | begin_on = (formateDate date) }
                            , begin_on_tmp = date
                        }
                            ! []

                EndOn ->
                    let
                        oldNewAbsence =
                            absenceModel.newAbsence
                    in
                        { absenceModel
                            | newAbsence = { oldNewAbsence | end_on = (formateDate date) }
                            , end_on_tmp = date
                        }
                            ! []


formateDate : Date -> String
formateDate date =
    Date.toFormattedString "y-MM-dd" date
