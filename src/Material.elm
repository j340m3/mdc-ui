module Material exposing (Model, Msg, init, subscriptions, update, view)

import Browser.Dom exposing (Viewport, getViewport)
import Browser.Events exposing (onResize)
import Element exposing (Device, Element, clip,paddingEach, column, none, px, el, fill, height, layout, padding, scrollbars, text, width)
import Html exposing (Html)
import Material.AppBar as AppBar
import Material.Theme
import Material.TopAppBar as TopAppBar exposing (..)
import Material.BottomAppBar as BottomAppBar
import Task


type alias Model =
    { bar : AppBar.AppBar
    , style : Material.Theme.Style
    , device : Device
    }


type Msg
    = OnResize Int Int
    | DeviceClassified Device
    | InitialViewport Viewport
    | AppBar AppBar.Msg


view : Model -> Html Msg
view model =
    let
        resulting =
            viewBody
    in
    layout [Element.mapAttribute AppBar <| Element.inFront (AppBar.view model.style model.bar)] <|
        el [paddingEach (AppBar.padding model.bar)] <|
        column
            []
            [ 
                
                el [] viewBody

            --             el [
            -- --                scrollbars
            --                     clip
            --                 ]
            --             viewBody
            ]


viewBody : Element m
viewBody =
    el
        [ scrollbars
        , padding 16
        ]
    <|
        text mytext


mytext =
    String.repeat 1000 "Hello \n"


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        OnResize width height ->
            update
                (DeviceClassified (Element.classifyDevice { width = width, height = height }))
                model

        DeviceClassified device ->
            ( { model | device = device }
            , Cmd.none
            )

        InitialViewport viewport ->
            let
                width =
                    round viewport.viewport.width

                height =
                    round viewport.viewport.height
            in
            update
                (DeviceClassified (Element.classifyDevice { width = width, height = height }))
                model
        AppBar msg_ ->
            (model, Cmd.none)


subscriptions : Model -> Sub Msg
subscriptions model =
    onResize <|
        \width height ->
            DeviceClassified (Element.classifyDevice { width = width, height = height })


init : ( Model, Cmd Msg )
init =
    ( { bar =
            AppBar.Both
                (TopAppBar.create
                    (TopAppBar.Anatomy
                        { actions = []
                        , background = TopAppBar.Color (RGB 255 255 255)
                        , bar = Height TopAppBar.Regular
                        , navigation = Just Menu
                        , overflow = False
                        , title = Title "Hello World2"
                        }
                    )
                    (TopAppBar.Behavior
                        { elevation = Above
                        , scrolling = Stay
                        }
                    )
                )
                (BottomAppBar.create
                    (BottomAppBar.Anatomy {
                        navigation= Nothing,
                        fab = Nothing,
                        actions = [],
                        overflow = False
                        , background = BottomAppBar.Color (Element.rgb255 255 255 255)
                    })
                    (BottomAppBar.Behavior{
                        scrolling = BottomAppBar.Stay,
                        elevation = BottomAppBar.Above
                    })
                )
      , style = Material.Theme.defaultStyle
      , device = defaultDevice
      }
    , Task.perform InitialViewport getViewport
    )


defaultDevice : Element.Device
defaultDevice =
    { class = Element.Desktop
    , orientation = Element.Landscape
    }

