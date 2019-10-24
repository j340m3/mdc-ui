module Main exposing (..)

import Material.TopAppBar exposing (TopAppBar)

main : Program Never Model Msg
main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }