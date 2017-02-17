module Models exposing (..)

import Absences.Models exposing (Model, initAbsenceModel)
import Material
import Routing


type alias Model =
    { mdl :          Material.Model
    , route :        Routing.Route
    , apiEndpoint :  String
    , absenceModel : Absences.Models.Model
    }


initialModel : Routing.Route -> Model
initialModel route =
    { mdl          = Material.model
    , route        = route
    , apiEndpoint  = "http://192.168.55.55:4000/api"
    , absenceModel = initAbsenceModel
    }
