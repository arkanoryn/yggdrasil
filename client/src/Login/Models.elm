module Login.Models exposing (..)

type alias Model =
    { token : Maybe String
    , loginForm : LoginForm
    }


type alias LoginForm =
    { username : String
    , password : String
    }


initLoginModel : Model
initLoginModel =
    { token = Nothing
    , loginForm = initLoginForm
    }


initLoginForm : LoginForm
initLoginForm =
    { username = ""
    , password = ""
    }
