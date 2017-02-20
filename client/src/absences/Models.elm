module Absences.Models exposing (..)

import Dropdown

type alias AbsenceId =
    String


type alias Model =
    { absences : List Absence
    , newAbsence : Absence
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
    }


initAbsence : Absence
initAbsence =
    { id = ""
    , kind = ""
    , status = ""
    , begin_on = ""
    , end_on = ""
    }
