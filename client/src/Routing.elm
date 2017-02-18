module Routing exposing (..)

import Absences.Models exposing (AbsenceId)
import Navigation exposing (Location)
import UrlParser exposing (..)


type Route
    = Home
    | AbsenceNew
    | AbsenceIndex
    | AbsenceShow AbsenceId
    | UsersIndex
    | NotFound


matchers : Parser (Route -> a) a
matchers =
    oneOf
        [ map Home top
        , map AbsenceNew (s "absences" </> s "new")
        , map AbsenceShow (s "absences" </> string)
        , map AbsenceIndex (s "absences")
        , map UsersIndex (s "users")
        ]


parseLocation : Location -> Route
parseLocation location =
    case (parseHash matchers location) of
        Just route ->
            route

        Nothing ->
            NotFound


pageToUrl : Route -> String
pageToUrl route =
    let
        url =
            case route of
                Home ->
                    ""

                AbsenceIndex ->
                    "absences"

                AbsenceNew ->
                    "absences/new"

                AbsenceShow id ->
                    "absences/" ++ id

                UsersIndex ->
                    "users"

                NotFound ->
                    "oops... not found"
    in
        "#" ++ url
