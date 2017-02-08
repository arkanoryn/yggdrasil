module Absences.Messages exposing (..)

import Absences.Models exposing (AbsenceId, Absence)
import Http


type Msg
    = OnFetchAll (Result Http.Error (List Absence))
    | OnCreate (Result Http.Error Absence)
    | CreateAbsence
    | ShowAbsences
    | ShowAbsence AbsenceId
    | ChangeKind String
    | ChangeBeginOn String
    | ChangeEndOn String
