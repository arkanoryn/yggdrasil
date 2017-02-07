module Models exposing (..)

import Absences.Models exposing (Model, initAbsenceModel)
import Material
import Routing


type alias Model =
    { mdl : Material.Model
    , absenceModel : Absences.Models.Model
    , route : Routing.Route
    }


initialModel : Routing.Route -> Model
initialModel route =
    { mdl = Material.model
    , absenceModel = initAbsenceModel
    , route = route
    }
