module Absences.Commands exposing (..)

import Absences.Messages exposing (..)
import Absences.Models exposing (AbsenceId, Absence)
import Http
import Json.Decode as Decode exposing (field)
import Json.Encode as Encode
import Models exposing (Model)
import Task


fetchAll : Model -> Cmd Msg
fetchAll model =
    Http.get (fetchAllUrl model.apiEndpoint) (Decode.at [ "data" ] collectionDecoder)
        |> Http.send OnFetchAll


fetchAllUrl : String -> String
fetchAllUrl endpoint =
    endpoint ++ "/absences/"


createAbsenceUrl : String -> String
createAbsenceUrl endpoint =
    endpoint ++ "/absences"


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


create : Model -> Absence -> Cmd Msg
create model absence =
    createAbsenceRequest model absence
        |> Http.send OnCreate


createAbsenceRequest : Model -> Absences.Models.Absence -> Http.Request Absence
createAbsenceRequest model absence =
    Http.request
        { body = encodedAbsence absence |> Http.jsonBody
        , expect = Http.expectJson (Decode.at [ "data" ] (Decode.at [ "create_absence" ] memberDecoder))
        , headers = []
        , method = "POST"
        , timeout = Nothing
        , url = createAbsenceUrl model.apiEndpoint
        , withCredentials = False
        }
