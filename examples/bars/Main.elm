module Main exposing (..)

import Browser exposing (Document, document)
import Html exposing (Html)
import Html.Attributes
import Material
import Material.AppBar as AppBar
import Material.Theme exposing (..)
import Material.TopAppBar as TopAppBar exposing (..)
import Browser.Dom exposing (getViewport, Viewport)


type alias Model =
    { material : Material.Model }


type Msg
    = MaterialMsg Material.Msg


main : Program {} Model Msg
main =
    document
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


init : {} -> ( Model, Cmd Msg )
init flags =
    let
        (material, effect) = Material.init
    in
    
    ( { material =
            material
      }
    , Cmd.map MaterialMsg effect 
    )


view : Model -> Document Msg
view model =
    { title = "bla"
    , body =
        [ Html.node "link" [ Html.Attributes.href "https://fonts.googleapis.com/css?family=Roboto", Html.Attributes.rel "stylesheet" ] []
        , Html.node "meta" [ 
            Html.Attributes.attribute "name" "viewport",
            Html.Attributes.attribute "content" "user-scalable=no, initial-scale=1, maximum-scale=1, minimum-scale=1, width=device-width, height=device-height, target-densitydpi=device-dpi"
        ]
        []
        , Material.view model.material
        ]
    }


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        MaterialMsg msg_ -> 
            let 
                (material, effect) = 
                    Material.update msg_ model.material
            in
                ({model | material = material}, Cmd.map MaterialMsg effect)


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.map MaterialMsg (Material.subscriptions model.material)
