module Users.Models exposing (..)


type alias UserId =
    String


type alias Model =
    { users : List User
    , userForm : User
    , raised : UserId
    }


type alias User =
    { id : UserId
    , username : String
    , email : String
    , password : String
    }


initUserModel : Model
initUserModel =
    { users = mockUsers
    , userForm = initUser
    , raised = "-1"
    }


initUser : User
initUser =
    { id = ""
    , username = ""
    , password = ""
    , email = ""
    }


mockUsers : List User
mockUsers =
    [ { id = "1", username = "ark", email = "arkanoryn@gmail.com", password = "" }
    , { id = "2", username = "ark2", email = "arkanoryn2@gmail.com", password = "" }
    , { id = "3", username = "ark3", email = "arkanoryn3@gmail.com", password = "" }
    , { id = "4", username = "ark4", email = "arkanoryn4@gmail.com", password = "" }
    , { id = "5", username = "ark5", email = "arkanoryn5@gmail.com", password = "" }
    ]
