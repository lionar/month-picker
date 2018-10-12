module Main exposing (main)

import Browser
import Html exposing (..)
import Mdc.MonthPicker as MonthPicker
import Time exposing (Month(..))


main : Program () Model Msg
main =
    Browser.sandbox
        { init = init
        , view = view
        , update = update
        }


type alias Model =
    { now : MonthPicker.Date
    , selected : MonthPicker.Date
    , viewYear : Int
    }


init : Model
init = 
    { now = ( Oct, 2018 )
    , selected = ( Mar, 2018 )
    , viewYear = 2018
    }


type Msg
    = Next
    | Prev
    | Select MonthPicker.Date


update : Msg -> Model -> Model
update msg ( { viewYear } as model ) =
    case msg of
        Next ->
            { model | viewYear = viewYear + 1 }
        
        Prev ->
            { model | viewYear = viewYear - 1 }

        Select date ->
            { model | selected = date }


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