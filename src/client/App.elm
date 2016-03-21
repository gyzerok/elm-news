module App (..) where

import Html exposing (..)
import Html.Events exposing (..)
import Effects as Fx exposing (Effects)

type alias Model = Int

init : ( Model, Effects Action )
init = ( 0, Fx.none )

type Action = Empty | Increment | Decrement

update : Action -> Model -> ( Model, Effects Action )
update action model =
    case action of
        Empty ->
            ( model, Fx.none )
        Increment ->
            ( model + 1, Fx.none )
        Decrement ->
            ( model - 1, Fx.none )

view : Signal.Address Action -> Model -> Html
view address model =
    div []
        [ button [ onClick address Decrement ] [ text "-" ]
        , span [] [ text (toString model) ]
        , button [ onClick address Increment ] [ text "+" ]
        ]
