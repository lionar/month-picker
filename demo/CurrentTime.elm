module CurrentTime exposing (main)

import Browser
import Html exposing (..)
import MonthPicker
import Task
import Time exposing (Month(..))


type alias Model =
    { now : MonthPicker.Date
    , selected : MonthPicker.Date
    , viewYear : Int
    }


defaults : Model
defaults = 
    { now = ( Jan, 2018 )
    , selected = ( Mar, 2018 )
    , viewYear = 2018
    }


-------------------------------------------------------------------
-- State
-------------------------------------------------------------------


type Msg
    = CurrentTime Time.Posix
    | Next
    | Prev
    | Select MonthPicker.Date


update : Msg -> Model -> ( Model, Cmd Msg )
update msg ( { viewYear } as model ) =
    case msg of
        CurrentTime posix ->
            ( { model | now = ( Time.toMonth Time.utc posix, Time.toYear Time.utc posix ) }, Cmd.none )

        Next ->
            ( { model | viewYear = viewYear + 1 }, Cmd.none )
        
        Prev ->
            ( { model | viewYear = viewYear - 1 }, Cmd.none )

        Select date ->
            ( { model | selected = date }, Cmd.none )


init : () -> ( Model, Cmd Msg )
init flags =
    ( defaults, Task.perform CurrentTime Time.now )


-------------------------------------------------------------------
-- View
-------------------------------------------------------------------


view : Model -> Html Msg
view { now, selected, viewYear } =
    main_ [] 
        [ MonthPicker.view
            { next = Next
            , prev = Prev
            , select = Select
            }
            now
            selected
            viewYear
        ]


-------------------------------------------------------------------
-- Setup
-------------------------------------------------------------------


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


main : Program () Model Msg
main =
    Browser.element
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }