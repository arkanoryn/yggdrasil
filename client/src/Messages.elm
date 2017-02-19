module Messages exposing (..)

import Absences.Messages
import Login.Messages
import Material
import Navigation exposing (Location)
import Routing exposing (Route)
import Users.Messages


type Msg
    = Mdl (Material.Msg Msg)
    | AbsencesMsg Absences.Messages.Msg
    | UsersMsg Users.Messages.Msg
    | LoginMsg Login.Messages.Msg
    | NewLocation Location
    | NavigateTo (Maybe Route)
