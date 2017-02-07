module Absences.Models exposing (..)

import Form exposing (Form)
import Form.Validate as Validate exposing (..)


type alias AbsenceId =
    String


type alias Model =
    { absences : (List Absence)
    , newAbsence : Form () Absence
    , selectedKind : Maybe String
    }


type alias Absence =
    { id : AbsenceId
    , kind : String
    , status : String
    , begin_on : String
    , end_on : String
    }


cleanAbsence : Form () Absence
cleanAbsence =
    Form.initial [] validation


initAbsenceModel : Model
initAbsenceModel =
    { absences = []
    , newAbsence = cleanAbsence
    , selectedKind = Nothing
    }


-- validation : Validation () Absence
-- validation =
--     map4 Absence
--         (field "id" string)
--         (field "kind" string)
--         (field "status" string)
--         (field "begin_on" string)
--         (field "end_on" string)
