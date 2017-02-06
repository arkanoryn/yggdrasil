module Messages exposing (..)

import Absences.Messages
import Material
import Navigation exposing (Location)
import Routing exposing (Route)


type Msg
    = Mdl (Material.Msg Msg)
    | AbsencesMsg Absences.Messages.Msg
    | NewLocation Location
    | NavigateTo (Maybe Route)
