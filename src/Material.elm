module Material exposing (Model, view, subscriptions, update, Msg, init)

import Element exposing (Device, layout, column, width, fill, Element, el, padding, text, scrollbars)
import Browser.Events exposing (onResize)
import Browser.Dom exposing (getViewport, Viewport)
import Material.AppBar as AppBar
import Material.TopAppBar as TopAppBar exposing (..)
import Material.Theme
import Task
import Html exposing (Html)
import Material.Theme exposing (..)

type alias Model = 
    {bar : AppBar.AppBar,
    style : Material.Theme.Style,
    device : Device}

type Msg
    = OnResize Int Int
    | DeviceClassified Device
    | InitialViewport Viewport


view : Model -> Html m
view model =
    layout [] <|
        column
            [width fill]
            [AppBar.view model.style model.bar (column [][]), 
            el [scrollbars]
            viewBody]

viewBody : Element m 
viewBody = 
    el 
        [padding 16]
        <| text mytext

mytext = String.repeat 10 "Hello \n"

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        OnResize width height-> 
            update 
                (DeviceClassified (Element.classifyDevice { width = width, height = height }) )
                model
        DeviceClassified device ->
            ( { model | device = device }
            , Cmd.none
            )
        InitialViewport viewport ->
            let
                width = round viewport.viewport.width
                height = round viewport.viewport.height
            in
                update 
                    (DeviceClassified (Element.classifyDevice { width = width, height = height }) )
                    model

subscriptions : Model -> Sub Msg
subscriptions model =
    onResize <|
        \width height ->
            DeviceClassified (Element.classifyDevice { width = width, height = height })

init : (Model, Cmd Msg)
init = 
   ( 
    { bar =
        AppBar.TopOnly <|
            TopAppBar.create
                (TopAppBar.Anatomy
                    { actions = []
                    , background = TopAppBar.Color (RGB 255 255 255)
                    , bar = Height TopAppBar.Regular
                    , navigation = Just Menu
                    , overflow = False
                    , title = Title "Hello World"
                    }
                )
                (TopAppBar.Behavior
                    { elevation = Above
                    , scrolling = Stay
                    }
                )
    , style = Material.Theme.defaultStyle
    , device = defaultDevice
    }

    , Task.perform InitialViewport getViewport 
    )

defaultDevice : Element.Device
defaultDevice =
    {
        class = Element.Desktop,
        orientation = Element.Landscape
    }