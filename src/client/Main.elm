import StartApp
import Task exposing (Task)
import Effects exposing (Effects, Never)
import Html exposing (Html)

import Counter

-- for elm-hot-loader to trigger a re-render
port swap : Signal Bool

main : Signal Html
main = app.html

port tasks : Signal (Task Never ())
port tasks = app.tasks

app : StartApp.App Counter.Model
app =
    StartApp.start
        { init = init
        , update = update
        , view = view
        , inputs = [ Signal.map (always NoOp) swap ]
        }

-- Stuff for hot replacemant

type alias Model = Counter.Model

init : ( Model, Effects Action )
init =
    let ( model, fx ) = Counter.init
    in
        ( model, fx |> Effects.map Child )

type Action = NoOp | Child Counter.Action

update : Action -> Model -> ( Model, Effects Action )
update action model =
    case action of
        Child act ->
            let ( model, fx ) = Counter.update act model
            in
                ( model, fx |> Effects.map Child )
        NoOp ->
            ( model, Effects.none )

view : Signal.Address Action -> Model -> Html
view address model =
    Counter.view (Signal.forwardTo address Child) model
