module Main exposing (..)

import Html exposing (h1, text)
import Html.App exposing (program)
import Html.Attributes exposing (id)
import Svg exposing (..)
import Svg.Attributes exposing (..)
import Keyboard.Extra as Keyboard


-- MODEL


type alias Model =
    { x : Int
    , y : Int
    , keyboardModel : Keyboard.Model
    }


init : ( Model, Cmd Msg )
init =
    let
        ( keyboardModel, keyboardCmd ) =
            Keyboard.init
    in
        ( { x = 10, y = 10, keyboardModel = keyboardModel }
        , Cmd.map Key keyboardCmd
        )



-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Key keyMsg ->
            let
                ( keyboardModel, keyboardCmd ) =
                    Keyboard.update keyMsg model.keyboardModel

                direction =
                    Keyboard.arrows keyboardModel

                newModel =
                    { model
                        | y = model.y - direction.y
                        , x = model.x + direction.x
                    }
            in
                ( { newModel | keyboardModel = keyboardModel }
                , Cmd.map Key keyboardCmd
                )

        NoOp ->
            ( model, Cmd.none )



-- VIEW


view model =
    h1 [] [ roundRect (toString model.x) (toString model.y) ]


roundRect : String -> String -> Html.Html msg
roundRect modelX modelY =
    svg [ width "120", height "120", viewBox "0 0 120 120" ]
        [ rect [ x modelX, y modelY, width "10", height "100", rx "15", ry "15" ] [] ]



-- SUBSCRIPTIONS


type Msg
    = NoOp
    | Key Keyboard.Msg


subscriptions model =
    Sub.batch [ Sub.map Key Keyboard.subscriptions ]



-- MAIN


main =
    program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
