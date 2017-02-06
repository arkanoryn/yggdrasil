module Absences.Messages exposing (..)

import Absences.Models exposing (AbsenceId, Absence)
import Http


type Msg
    = OnFetchAll (Result Http.Error (List Absence))
    | ShowAbsences
    | ShowAbsence AbsenceId
