module Models exposing (..)

import Absences.Models exposing (initAbsenceModel)
import Login.Models exposing (initLoginModel)
import Material
import Routing
import Users.Models exposing (initUserModel)


type alias Model =
    { mdl : Material.Model
    , route : Routing.Route
    , apiEndpoint : String
    , loginModel : Login.Models.Model
    , absenceModel : Absences.Models.Model
    , userModel : Users.Models.Model
    }


initialModel : Routing.Route -> Model
initialModel route =
    { mdl = Material.model
    , route = route
    , apiEndpoint = "http://192.168.55.55:4000/api"
    , loginModel = initLoginModel
    , absenceModel = initAbsenceModel
    , userModel = initUserModel
    }
