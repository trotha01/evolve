module Aquifex exposing (..)

import Html exposing (Html, h1, text)
import Html.App exposing (program)
import Html.Attributes exposing (id)
import Svg exposing (..)
import Svg.Attributes exposing (..)


-- MODEL


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
    | Move { x : Int, y : Int }


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Move direction ->
            let
                newModel =
                    { model
                        | y = model.y - direction.y
                        , x = model.x + direction.x
                    }
            in
                ( newModel, Cmd.none )

        NoOp ->
            ( model, Cmd.none )



-- VIEW


view : Model -> Html Msg
view model =
    roundRect (toString model.x) (toString model.y)


roundRect : String -> String -> Html msg
roundRect modelX modelY =
    rect [ x modelX, y modelY, width "10", height "100", rx "15", ry "15" ] []
