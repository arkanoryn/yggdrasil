module Messages exposing (..)

import Absences.Messages
import Login.Messages
import Material
import Models exposing (Flags)
import Navigation exposing (Location)
import Routing exposing (Route)
import Users.Messages


type Msg
    = Mdl (Material.Msg Msg)
    | AbsencesMsg Absences.Messages.Msg
    | UsersMsg Users.Messages.Msg
    | LoginMsg Login.Messages.Msg
    | SetFlags Flags
    | NewLocation Location
    | NavigateTo (Maybe Route)
    | NoOp
