module Absences.Messages exposing (..)

import Absences.Models exposing (AbsenceId, Absence, DateField(..))
import Date exposing (Date)
import Http


type Msg
    = OnFetchAll (Result Http.Error (List Absence))
    | OnCreate (Result Http.Error Absence)
    | CreateAbsence
    | ShowAbsences
    | ShowAbsence AbsenceId
    | SelectKind String
    | OpenDropdown DateField
    | CloseDropdown
    | SelectDate DateField Date
