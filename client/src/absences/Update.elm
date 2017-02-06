module Absences.Update exposing (..)

import Absences.Messages exposing (Msg(..))
import Absences.Models exposing (Absence)
import Navigation


update : Msg -> List Absence -> ( List Absence, Cmd Msg )
update msg absences =
    case msg of
        OnFetchAll (Ok newAbsences) ->
            newAbsences ! []

        OnFetchAll (Err error) ->
            absences ! []

        ShowAbsences ->
            ( absences, Navigation.newUrl "#absences" )

        ShowAbsence id ->
            ( absences, Navigation.newUrl ("#absences/" ++ id) )
