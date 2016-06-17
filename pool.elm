module Pool exposing (..)

import Html exposing (Html, div, text)
import Html.App exposing (program, map)
import Html.Attributes exposing (id)
import Svg exposing (..)
import Svg.Attributes exposing (..)
import Co


type alias Model =
    { cos : List Co.Model
    }


init : ( Model, Cmd Msg )
init =
    let
        ( co1, _ ) =
            Co.init

        ( co2, _ ) =
            Co.init
    in
        ( { cos = [ co1, co2 ] }
        , Cmd.none
        )



-- UPDATE


type Msg
    = NoOp
    | CoCmd Co.Msg



-- VIEW


view : Model -> Html Msg
view model =
    g [] (List.map (\co -> (map CoCmd (Co.view co))) model.cos)
