module Messages exposing (..)

import Navigation exposing (Location)
import Absences.Messages
import Material

type Msg
    = Mdl ( Material.Msg  Msg )
    | AbsencesMsg Absences.Messages.Msg
    | OnLocationChange Location
