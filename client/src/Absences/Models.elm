module Absences.Models exposing (..)

import Date exposing (Date, Month(..))
import Date.Extra as Date

type alias AbsenceId =
    String


type alias Model =
    { absences :      List Absence
    , newAbsence :    Absence
    , openDateField : Maybe DateField
    , end_on_tmp :    Date
    , begin_on_tmp :  Date
    }


type alias Absence =
    { id :       AbsenceId
    , kind :     String
    , status :   String
    , begin_on : String
    , end_on :   String
    }


type DateField
    = BeginOn
    | EndOn


initAbsenceModel : Model
initAbsenceModel =
    { absences      = []
    , newAbsence    = initAbsence
    , openDateField = Nothing
    , end_on_tmp    = (Date.fromCalendarDate 2017 Jan 01)
    , begin_on_tmp  = (Date.fromCalendarDate 2017 Jan 01)
    }


initAbsence : Absence
initAbsence =
    { id       = ""
    , kind     = ""
    , status   = ""
    , begin_on = ""
    , end_on   = ""
    }
