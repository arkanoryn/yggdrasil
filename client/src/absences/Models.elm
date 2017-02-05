module Absences.Models exposing (..)


type alias AbsenceId =
    String


type alias Absence =
    { id : AbsenceId
    , kind : String
    , status : String
    , begin_on : String
    , end_on : String
    }


new : Absence
new =
    { id = "0"
    , kind = "vacation"
    , status = "pending"
    , begin_on = "2017-01-01"
    , end_on = "2017-01-01"
    }
