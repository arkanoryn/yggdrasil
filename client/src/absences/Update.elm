module Absences.Update exposing (..)

import Messages
import Absences.Messages exposing (Msg(..))
import Absences.Models exposing (Model, Absence)
import Navigation
import Absences.Commands as API


update : Msg -> Absences.Models.Model -> ( Absences.Models.Model, Cmd Msg )
update msg absenceModel =
    case msg of
        OnFetchAll (Ok newAbsences) ->
            { absenceModel | absences = newAbsences } ! []

        OnFetchAll (Err error) ->
            absenceModel ! []

        OnCreate (Ok newAbsence) ->
                { absenceModel | newAbsence =Absences.Models.initAbsence } ! []

        OnCreate (Err error) ->
            let
                _ =
                    Debug.log "Create absence failed: " error
            in
            absenceModel ! []

        CreateAbsence ->
            absenceModel ! [ API.create absenceModel.newAbsence ]

        ShowAbsences ->
            absenceModel ! [ Navigation.newUrl "#absences" ]

        ShowAbsence id ->
            absenceModel ! [ Navigation.newUrl ("#absences/" ++ id) ]

        ChangeKind newKind ->
            let
                oldNewAbsence =
                    absenceModel.newAbsence
            in
                { absenceModel
                    | newAbsence = { oldNewAbsence | kind = newKind }
                }
                    ! []

        ChangeBeginOn newBeginOn ->
            let
                oldNewAbsence =
                    absenceModel.newAbsence
            in
                { absenceModel
                    | newAbsence = { oldNewAbsence | begin_on = newBeginOn }
                }
                    ! []

        ChangeEndOn newEndOn ->
            let
                oldNewAbsence =
                    absenceModel.newAbsence
            in
                { absenceModel
                    | newAbsence = { oldNewAbsence | end_on = newEndOn }
                }
                    ! []
