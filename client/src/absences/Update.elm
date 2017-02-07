module Absences.Update exposing (..)

import Absences.Messages exposing (Msg(..))
import Absences.Models exposing (Model, Absence)
import Navigation


update : Msg -> Absences.Models.Model -> ( Absences.Models.Model, Cmd Msg )
update msg absenceModel =
    case msg of
        OnFetchAll (Ok newAbsences) ->
            { absenceModel | absences = newAbsences } ! []

        OnFetchAll (Err error) ->
            absenceModel ! []

        CreateNewAbsence ->
            absenceModel ! []

        CreateSucceeded _ ->
            absenceModel ! []

        CreateFailed error ->
            absenceModel ! []

        ShowAbsences ->
            ( absenceModel, Navigation.newUrl "#absences" )

        ShowAbsence id ->
            ( absenceModel, Navigation.newUrl ("#absences/" ++ id) )
