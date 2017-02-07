module Absences.Commands exposing (..)

import Models exposing (Model)
import Absences.Messages exposing (..)
import Absences.Models exposing (AbsenceId, Absence)
import Http
import Json.Decode as Decode exposing (field)
import Json.Encode as Encode
import Task


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


encodeAbsence : Absences.Models.Absence -> Encode.Value
encodeAbsence absence =
    Encode.object
        [ ( "absence"
          , Encode.object
                [ ( "kind", Encode.string absence.kind )
                , ( "begin_on", Encode.string absence.begin_on )
                , ( "end_on", Encode.string absence.end_on )
                ]
          )
        ]

createAbsence : Absences.Models.Absence -> Cmd Msg
createAbsence absence =
   Cmd.none
    -- Http.send Http.defaultSettings
    --     { verb = "POST"
    --     , url = "lol" ++ "absences"
    --     , body = Http.string (encodeAbsence absence |> Encode.encode 0)
    --     , headers = [ ( "Content-Type", "application/json" ) ]
    --     }
    --     |> Http.fromJson (Decode.at ["data"] memberDecoder)
    --     |> Task.perform CreateAbsenceFailed CreateAbsenceSucceeded
