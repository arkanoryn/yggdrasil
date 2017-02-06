module Layout.Header exposing (view)

import Html exposing (Html, div, text, span)
import Material.Layout as Layout
import Messages exposing (Msg(..))
import Models exposing (Model)


view : Model -> List (Html Msg)
view model =
    [ view_ model ]


view_ : Model -> Html Msg
view_ model =
    Layout.row
        []
        [ Layout.title [] [ text "My Intranet" ]
        , Layout.spacer
        , Layout.navigation []
            [ Layout.link
                [ Layout.href "https://github.com/arkanoryn/yggdrasil" ]
                [ span [] [ text "github" ] ]
            ]
        ]
