module Layout.SubMenu exposing (view)

import Html exposing (Html, text)
import Messages exposing (Msg(..))
import Models exposing (Model)


view : Model -> ( List (Html Msg), List a )
view model =
    ( tabTitles, [] )


tabTitles : List (Html a)
tabTitles =
    List.map (\( x, _, _ ) -> text x) tabs


tabs : List ( String, String, String )
tabs =
    [ ( "Absence", "absence", "string_view" )
    ]
