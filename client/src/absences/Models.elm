module Absences.Models exposing (..)


type alias AbsenceId =
    String


type alias Model =
    { absences : List Absence
    , newAbsence : Absence
    , selectedKind : Maybe String
    }


type alias Absence =
    { id : AbsenceId
    , kind : String
    , status : String
    , begin_on : String
    , end_on : String
    }


initAbsenceModel : Model
initAbsenceModel =
    { absences = []
    , newAbsence = initAbsence
    , selectedKind = Nothing
    }


initAbsence : Absence
initAbsence =
    { id = ""
    , kind = ""
    , status = ""
    , begin_on = ""
    , end_on = ""
    }
