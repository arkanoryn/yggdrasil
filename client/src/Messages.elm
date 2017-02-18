module Messages exposing (..)

import Absences.Messages
import Users.Messages
import Material
import Navigation exposing (Location)
import Routing exposing (Route)


type Msg
    = Mdl (Material.Msg Msg)
    | AbsencesMsg Absences.Messages.Msg
    | UsersMsg Users.Messages.Msg
    | NewLocation Location
    | NavigateTo (Maybe Route)
