module MonthPicker exposing (Date, view)

import Html exposing (..)
import Html.Attributes exposing (class)
import Html.Events exposing (onClick)
import Time exposing (Month(..))


type alias Year = Int


type alias Date = ( Month, Year )


months : Year -> List Date
months year =
    [ ( Jan, year )
    , ( Feb, year )
    , ( Mar, year )
    , ( Apr, year )
    , ( May, year )
    , ( Jun, year )
    , ( Jul, year )
    , ( Aug, year )
    , ( Sep, year )
    , ( Oct, year )
    , ( Nov, year )
    , ( Dec, year )
    ]


toMonthString : Month -> String
toMonthString month =
    case month of
        Jan -> "Jan"
        Feb -> "Feb"
        Mar -> "Mar"
        Apr -> "Apr"
        May -> "May"
        Jun -> "Jun"
        Jul -> "Jul"
        Aug -> "Aug"
        Sep -> "Sep"
        Oct -> "Oct"
        Nov -> "Nov"
        Dec -> "Dec"


---------------------------------------------------------------------------------------------------------------
-- View
---------------------------------------------------------------------------------------------------------------


type alias Msgs msg =
    { next : msg
    , prev : msg
    , select : Date -> msg
    }


view : Msgs msg -> Date -> Date -> Year -> Html msg
view msgs now selected viewYear =
    div [ class "month-picker" ] 
        [ header [] 
            [ h1 [] [ text <| toTitle selected ]
            ]
        , main_ [] 
            [ header []
                [ i [ class "material-icons chevron", onClick msgs.prev ] [ text "chevron_left" ]
                , h2 [] [ text ( String.fromInt viewYear ) ]
                , i [ class "material-icons chevron", onClick msgs.next ] [ text "chevron_right" ]
                ]
            , ol [] <| List.map ( monthItem msgs.select now selected ) ( months viewYear )
            ]
        ]


monthItem : ( Date -> msg ) -> Date -> Date -> Date -> Html msg
monthItem select now selected ( ( month, year ) as date ) =
    li 
        [ onClick <| select date
        , sel selected date
        , current now date
        ] [ text <| toMonthString month ]


toTitle : Date -> String
toTitle ( month, year ) =
    ( toMonthString month ) ++ ", " ++ ( String.fromInt year )


sel : Date -> Date -> Attribute msg
sel selected date =
    if selected == date then
        class "selected"
    else
        class ""


current : Date -> Date -> Attribute msg
current now date =
    if now == date then
        class "now"
    else
        class ""