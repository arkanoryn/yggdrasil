module Login.Models exposing (..)

import Users.Models exposing (User)

type alias Model =
    { user : Maybe User
    , token : String
    , loginForm : LoginForm
    }


type alias LoginForm =
    { username : String
    , password : String
    }

initModel : Model
initModel =
    { user = Nothing
    , token = ""
    , loginForm = initLoginForm
    }


initLoginForm : LoginForm
initLoginForm =
    { username = ""
    , password = ""
    }
