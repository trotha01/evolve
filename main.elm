module Main exposing (..)

import Html exposing (Html, div, text)
import Html.App exposing (program, map)
import Html.Attributes exposing (id)
import Svg exposing (..)
import Svg.Attributes exposing (..)
import Keyboard.Extra as Keyboard
import Aquifex
import Pool


-- MODEL


type alias Model =
    { aquifex : Aquifex.Model
    , pool : Pool.Model
    , keyboard : Keyboard.Model
    }


init : ( Model, Cmd Msg )
init =
    let
        ( keyboard, keyboardCmd ) =
            Keyboard.init

        ( aquifex, aquifexCmd ) =
            Aquifex.init

        ( pool, poolCmd ) =
            Pool.init
    in
        ( { aquifex = aquifex
          , keyboard = keyboard
          , pool = pool
          }
        , Cmd.batch
            [ Cmd.map KeyPress keyboardCmd
            , Cmd.map AquifexCmd aquifexCmd
            , Cmd.map PoolCmd poolCmd
            ]
        )



-- UPDATE


type Msg
    = NoOp
    | KeyPress Keyboard.Msg
    | AquifexCmd Aquifex.Msg
    | PoolCmd Pool.Msg


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

        PoolCmd aquiMsg ->
            ( model, Cmd.none )

        NoOp ->
            ( model, Cmd.none )



-- VIEW


view : Model -> Html Msg
view model =
    svg [ width "120", height "120", viewBox "0 0 120 120" ]
        [ map AquifexCmd (Aquifex.view model.aquifex)
        , map PoolCmd (Pool.view model.pool)
        ]



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
