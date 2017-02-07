module Absences.Messages exposing (..)

import Absences.Models exposing (AbsenceId, Absence)
import Http
import Form

type Msg
    = OnFetchAll (Result Http.Error (List Absence))
    | CreateAbsence
    | CreateAbsenceSucceeded Absence
    | CreateAbsenceFailed Http.Error
    | ShowAbsences
    | ShowAbsence AbsenceId
    | KindDropdownChanged (Maybe String)
    | NewAbsenceFormMsg Form.Msg
