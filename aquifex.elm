module Aquifex exposing (..)

-- MODEL


type alias Model =
    { x : Int
    , y : Int
    }


init : ( Model, Cmd Msg )
init =
    ( { x = 10, y = 10 }
    , Cmd.None
    )



-- UPDATE
