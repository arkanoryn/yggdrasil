module Users.Views.Index exposing (view, header)

import Html exposing (Html, div, text)
import Layout.Header as Header
import Material.Button as Button
import Material.Card as Card
import Material.Color as Color
import Material.Elevation as Elevation
import Material.Grid exposing (grid, size, cell, Device(..))
import Material.Icon as Icon
import Material.Options as Options exposing (onClick, css)
import Material.Typography as Typography
import Messages exposing (Msg(..))
import Models exposing (Model)
import Users.Messages
import Users.Models exposing (User, UserId)


view : Model -> Html Msg
view model =
    grid []
        (userList model model.userModel)


userList : Model -> Users.Models.Model -> List (Material.Grid.Cell Msg)
userList model usersModel =
    (List.indexedMap (userCard model usersModel) usersModel.users)


userCard : Model -> Users.Models.Model -> Int -> Users.Models.User -> Material.Grid.Cell Msg
userCard model usersModel id user =
    cell
        [ size Desktop 3
        , size Tablet 6
        , size Phone 12
        ]
        [ Card.view
            [ dynamic user.id usersModel
            , css "width" "100%"
            , css "padding" "0"
            ]
            [ Card.menu
                [ Card.border
                ]
                [ Button.render Mdl
                    [ 0, 0, id ]
                    model.mdl
                    [ Button.icon
                    , Button.ripple
                    , blue
                      -- , Options.onClick <| NavigateTo <| Just (UsersEdit users.id)
                    ]
                    [ Icon.i "mode_edit" ]
                , Button.render Mdl
                    [ 0, 1, id ]
                    model.mdl
                    [ Button.icon
                    , Button.ripple
                    , Button.accent
                    , red
                      -- , Options.onClick <| UsersMsg <| (Users.Messages.DeleteUsers users)
                    ]
                    [ Icon.i "delete" ]
                ]
            , Card.title
                [ css "height" "256px"
                , css "padding" "0"
                , css "background" ("url('" ++ (background user.username) ++ "') center / cover")
                ]
                [ Card.head
                    [ css "background" "rgba(0, 0, 0, 0.5)"
                    , css "width" "100%"
                    ]
                    [ Options.span
                        [ white
                        , Typography.title
                        , Typography.contrast 1.0
                        , css "padding" "16px"
                          -- Restore default padding inside scrim
                        , css "width" "100%"
                        ]
                        [ text user.username ]
                    ]
                ]
            , Card.text []
                [ text user.email ]
            ]
        ]


red : Options.Property c m
red =
    Color.text (Color.color Color.Red Color.A200)


blue : Options.Property c m
blue =
    Color.text (Color.color Color.Blue Color.A200)


white : Options.Property c m
white =
    Color.text Color.white


background : String -> String
background str =
    "https://api.adorable.io/avatars/300/" ++ str ++ ".png"


dynamic : UserId -> Users.Models.Model -> Options.Style Msg
dynamic id usersModel =
    [ if usersModel.raised == id then
        Elevation.e8
      else
        Elevation.e2
    , Elevation.transition 250
    , Options.onMouseEnter (UsersMsg <| (Users.Messages.Raise id))
    , Options.onMouseLeave (UsersMsg <| (Users.Messages.Raise "-1"))
      -- , Options.onClick <| NavigateTo <| Just (UsersShow id)
    ]
        |> Options.many


header : Model -> List (Html Msg)
header model =
    Header.defaultHeaderWithNavigation
        "Users"
        []


addUsersButton : Model -> Html Msg
addUsersButton model =
    Button.render Mdl
        [ 0, 0 ]
        model.mdl
        [ css "position" "fixed"
        , css "display" "block"
        , css "right" "0"
        , css "top" "0"
        , css "margin-right" "35px"
        , css "margin-top" "35px"
        , css "z-index" "900"
        , Button.fab
        , Button.colored
        , Button.ripple
          -- , Options.onClick <| NavigateTo <| Just UsersNew
        ]
        [ Icon.i "add" ]
