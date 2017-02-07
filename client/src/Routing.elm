module Routing exposing (..)

import Absences.Models exposing (AbsenceId)
import Navigation exposing (Location)
import UrlParser exposing (..)


type Route
    = HomeRoute
    | NewAbsenceRoute
    | AbsencesRoute
    | AbsenceRoute AbsenceId
    | NotFoundRoute


matchers : Parser (Route -> a) a
matchers =
    oneOf
        [ map HomeRoute top
        , map AbsenceRoute (s "absences" </> string)
        , map AbsencesRoute (s "absences")
        ]


parseLocation : Location -> Route
parseLocation location =
    case (parseHash matchers location) of
        Just route ->
            route

        Nothing ->
            NotFoundRoute


pageToUrl : Route -> String
pageToUrl route =
    let
        url =
            case route of
                HomeRoute ->
                    ""

                AbsencesRoute ->
                    "absences"

                AbsenceRoute id ->
                    "absences/" ++ id

                _ ->
                    "notofound"
    in
        "#" ++ url
