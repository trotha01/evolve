module Main exposing (..)

import Html exposing (Html, h1, text)
import Html.App exposing (program, map)
import Html.Attributes exposing (id)
import Svg exposing (..)
import Svg.Attributes exposing (..)
import Keyboard.Extra as Keyboard
import Aquifex


-- MODEL


type alias Model =
    { aquifex : Aquifex.Model
    , keyboard : Keyboard.Model
    }


init : ( Model, Cmd Msg )
init =
    let
        ( keyboard, keyboardCmd ) =
            Keyboard.init

        ( aquifex, aquifexCmd ) =
            Aquifex.init
    in
        ( { aquifex = aquifex, keyboard = keyboard }
        , Cmd.batch
            [ Cmd.map KeyPress keyboardCmd
            , Cmd.map AquifexCmd aquifexCmd
            ]
        )



-- UPDATE


type Msg
    = NoOp
    | KeyPress Keyboard.Msg
    | AquifexCmd Aquifex.Msg


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        KeyPress keyMsg ->
            let
                ( keyboard, keyboardCmd ) =
                    Keyboard.update keyMsg model.keyboard

                direction =
                    Keyboard.arrows keyboard

                ( newAquifex, aquiCmd ) =
                    Aquifex.update (Aquifex.Move direction) model.aquifex

                newModel =
                    { model | aquifex = newAquifex, keyboard = keyboard }
            in
                ( newModel
                , Cmd.batch
                    [ Cmd.map KeyPress keyboardCmd
                    , Cmd.map AquifexCmd aquiCmd
                    ]
                )

        AquifexCmd aquiMsg ->
            ( model, Cmd.none )

        NoOp ->
            ( model, Cmd.none )



-- VIEW


view : Model -> Html Msg
view model =
    h1 [] [ map AquifexCmd (Aquifex.view model.aquifex) ]



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch [ Sub.map KeyPress Keyboard.subscriptions ]



-- MAIN


main =
    program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
