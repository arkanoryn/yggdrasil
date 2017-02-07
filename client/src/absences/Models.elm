module Absences.Models exposing (..)


type alias AbsenceId =
    String


type alias Model =
    { absences : (List Absence)
    , newAbsence : Absence
    }


type alias Absence =
    { id : AbsenceId
    , kind : String
    , status : String
    , begin_on : String
    , end_on : String
    }


cleanAbsence : Absence
cleanAbsence =
    { id = ""
    , kind = ""
    , status = ""
    , begin_on = ""
    , end_on = ""
    }


initAbsenceModel : Model
initAbsenceModel =
    { absences = []
    , newAbsence = cleanAbsence
    }
