module Pool exposing (..)

import Html exposing (Html, h1, text)
import Html.App exposing (program)
import Html.Attributes exposing (id)
import Svg exposing (..)
import Svg.Attributes exposing (..)


type alias Model =
    { x : Int
    , y : Int
    }


init : ( Model, Cmd Msg )
init =
    ( { x = 10, y = 10 }
    , Cmd.none
    )



-- UPDATE


type Msg
    = NoOp



-- VIEW


view : Model -> Html Msg
view model =
    roundRect (toString model.x) (toString model.y)


roundRect : String -> String -> Html msg
roundRect modelX modelY =
    rect [ x modelX, y modelY, width "5", height "5", rx "15", ry "15" ] []
