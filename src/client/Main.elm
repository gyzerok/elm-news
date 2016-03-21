import StartApp
import Task exposing (Task)
import Effects exposing (Effects, Never)
import Html exposing (Html)

import App

-- for elm-hot-loader to trigger a re-render
port swap : Signal Bool

main : Signal Html
main = app.html

port tasks : Signal (Task Never ())
port tasks = app.tasks

app : StartApp.App App.Model
app =
    StartApp.start
        { init = init
        , update = update
        , view = view
        , inputs = [ Signal.map (always NoOp) swap ]
        }

-- Stuff for hot replacemant

type alias Model = App.Model

init : ( Model, Effects Action )
init =
    let ( model, fx ) = App.init
    in
        ( model, fx |> Effects.map AppAction )

type Action = NoOp | AppAction App.Action

update : Action -> Model -> ( Model, Effects Action )
update action model =
    case action of
        AppAction act ->
            let ( model, fx ) = App.update act model
            in
                ( model, fx |> Effects.map AppAction )
        NoOp ->
            ( model, Effects.none )

view : Signal.Address Action -> Model -> Html
view address model =
    App.view (Signal.forwardTo address AppAction) model
