module Absences.Messages exposing (..)


import Http
import Absences.Models exposing (AbsenceId, Absence)

type Msg
    = OnFetchAll (Result Http.Error (List Absence))
    | ShowAbsences
    | ShowAbsence AbsenceId
