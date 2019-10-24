module Main exposing (..)

import Material.TopAppBar as TopAppBar exposing (..)
import Material
import Material.Theme exposing (..)
import Material.AppBar as AppBar
import Html exposing (Html)
import Html.Attributes
import Browser exposing (Document, document)

type alias Model =
    {material: Material.Model}

type Msg = 
    Noop


main : Program {} Model Msg
main =
    document
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
    
init : {} -> (Model, Cmd Msg)
init flags = 
    ({material = {bar = AppBar.TopOnly <| TopAppBar.create 
                (TopAppBar.Anatomy {
                    actions = []
                    , background = TopAppBar.Color (RGB 255 255 255)
                    , bar = Height TopAppBar.Regular
                    , navigation = Just Menu
                    , overflow = False
                    , title = Title "Hello World"
                })
                (TopAppBar.Behavior {
                    elevation = Same,
                    scrolling = Stay
                })
        , style = Material.Theme.defaultStyle}}, Cmd.none)

view : Model -> Document Msg
view model =
    {
        title = "bla",
        body = [Html.node "link" [ Html.Attributes.href "https://fonts.googleapis.com/css?family=Roboto", Html.Attributes.rel "stylesheet" ] []
            , Material.view model.material]
    }
    

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Noop ->
            ( model, Cmd.none )

subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none