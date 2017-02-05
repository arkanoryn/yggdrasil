module Tests exposing (..)

import Test exposing (..)
import Expect
import String
import Json.Decode as JD
import Types exposing (Absence)
import Decoders exposing (absencesDecoder)


all : Test
all =
    describe "A Test Suite"
        [ test "decoding absences" <|
            \() ->
                Expect.equal (JD.decodeString absencesDecoder "[{\"id\": 1, \"state\": 2}]") (Ok [ (Absence (Just 1) 2) ])
        ]
