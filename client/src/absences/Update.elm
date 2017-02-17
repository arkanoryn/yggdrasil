module Absences.Update exposing (..)

import Absences.Commands as API
import Absences.Messages exposing (Msg(..))
import Absences.Models exposing (Absence)
import Models exposing (Model)
import Navigation


update : Model -> Msg -> Absences.Models.Model -> ( Absences.Models.Model, Cmd Msg )
update model msg absenceModel =
    case msg of
        OnFetchAll (Ok newAbsences) ->
            { absenceModel | absences = newAbsences } ! []

        OnFetchAll (Err error) ->
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
            absenceModel ! [ (Navigation.newUrl "#absences") ]

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
