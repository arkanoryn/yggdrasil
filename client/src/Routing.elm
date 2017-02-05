module Routing exposing (..)

import Navigation exposing (Location)
import Absences.Models exposing (AbsenceId)
import UrlParser exposing (..)

type Route
    = AbsencesRoute
    | AbsenceRoute AbsenceId
    | NotFoundRoute


matchers : Parser (Route -> a) a
matchers =
    oneOf
        [ map AbsencesRoute top
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
