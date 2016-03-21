import StartApp
import Task exposing (Task)
import Effects as Fx exposing (Effects, Never)
import Html exposing (..)
import Html.Events exposing (..)

-- for elm-hot-loader to trigger a re-render
port swap : Signal Bool

app : StartApp.App Model
app =
    StartApp.start
        { init = init
        , update = update
        , view = view
        , inputs = [ Signal.map (always Empty) swap ]
        }

main : Signal Html
main = app.html

port tasks : Signal (Task Never ())
port tasks = app.tasks

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
