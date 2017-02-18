module Users.Models exposing (..)

type alias UserId =
    String


type alias Model =
    { users :        List User
    , userForm :     User
    , selectedKind : Maybe String
    }


type alias User =
    { id :       UserId
    , username : String
    , email :    String
    , password : String
    }


initUserModel : Model
initUserModel =
    { users        = []
    , userForm     = initUser
    , selectedKind = Nothing
    }


initUser : User
initUser =
    { id       = ""
    , username = ""
    , password = ""
    , email    = ""
    }
