module Absences.Commands exposing (..)

import Absences.Messages exposing (..)
import Absences.Models exposing (AbsenceId, Absence)
import Http
import Json.Decode as Decode exposing (field)


fetchAll : Cmd Msg
fetchAll =
    Http.get fetchAllUrl (Decode.at [ "data" ] collectionDecoder)
        |> Http.send OnFetchAll


hostApi : String
hostApi =
    "http://192.168.55.55:4000/api"


fetchAllUrl : String
fetchAllUrl =
    hostApi ++ "/absences/"


collectionDecoder : Decode.Decoder (List Absence)
collectionDecoder =
    Decode.at [ "absences" ] (Decode.list memberDecoder)


memberDecoder : Decode.Decoder Absence
memberDecoder =
    Decode.map5 Absence
        (field "id" Decode.string)
        (field "kind" Decode.string)
        (field "status" Decode.string)
        (field "begin_on" Decode.string)
        (field "end_on" Decode.string)
