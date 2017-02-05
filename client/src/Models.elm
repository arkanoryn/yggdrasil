module Models exposing (..)

import Absences.Models exposing (Absence)
import Routing
import Material


type alias Model =
    { mdl : Material.Model
    , absences : List Absence
    , route : Routing.Route
    }


initialModel : Routing.Route -> Model
initialModel route =
    { mdl = Material.model
    , absences = [ ]
    , route = route
    }

-- test