module Material exposing (..)

import Element exposing (..)
import Material.AppBar
import Material.Theme
import Html exposing (Html)

type alias Model = 
    {bar : Material.AppBar.AppBar,
    style : Material.Theme.Style}

view : Model -> Html m
view model =
    layout [] <|
        column 
            [width fill]
            [Material.AppBar.view model.style model.bar viewBody]

viewBody : Element m 
viewBody = 
    text "I'm da body"