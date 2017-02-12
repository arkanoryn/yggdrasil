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


createAbsenceUrl : String
createAbsenceUrl =
    hostApi ++ "/absences"


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


encodedAbsence : Absences.Models.Absence -> Encode.Value
encodedAbsence absence =
    Encode.object
        [ ( "absence"
          , Encode.object
                [ ( "kind", Encode.string absence.kind )
                , ( "begin_on", Encode.string absence.begin_on )
                , ( "end_on", Encode.string absence.end_on )
                ]
          )
        ]


create : Absence -> Cmd Msg
create absence =
    createAbsenceRequest absence
        |> Http.send OnCreate


createAbsenceRequest : Absences.Models.Absence -> Http.Request Absence
createAbsenceRequest absence =
    Http.request
        { body = encodedAbsence absence |> Http.jsonBody
        , expect = Http.expectJson (Decode.at ["data"] (Decode.at ["create_absence"] memberDecoder))
        , headers = []
        , method = "POST"
        , timeout = Nothing
        , url = createAbsenceUrl
        , withCredentials = False
        }
