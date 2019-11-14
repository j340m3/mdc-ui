module Material.TopAppBar exposing (Anatomy(..), Background(..), Bar(..), BarHeight(..), Behavior(..), Color(..), ContextualActionBar(..), DesktopOnlyBarHeight(..), ElevationBehavior(..), Navigation(..), ScrollingBehavior(..), Title(..), TopAppBar, create, view)

import Element exposing (..)
import Element.Font as Font
import Element.Background as Background
import Element.Border as Border
import Html exposing (Html)
import Internal.Icon exposing (Icon)
import Internal.Image exposing (Image)
import Material.Theme exposing (Style)


type TopAppBar
    = TopAppBar
        { anatomy : Anatomy
        , behavior : Behavior
        }


type Color
    = RGB Int Int Int


type Anatomy
    = Anatomy
        { bar : Bar
        , navigation : Maybe Navigation
        , title : Title
        , actions : List Icon
        , overflow : Bool
        , background : Background
        }


type Title
    = Title String
    | Logo Image


type Background
    = Color Color
    | Image Image


type Behavior
    = Behavior
        { scrolling : ScrollingBehavior
        , elevation : ElevationBehavior
        }


type ScrollingBehavior
    = Stay
    | Transform


type ElevationBehavior
    = Same
    | Above


type Navigation
    = Menu
    | Up
    | Back


type Bar
    = Height BarHeight


type BarHeight
    = Regular
    | Prominent
    | Desktop DesktopOnlyBarHeight


type DesktopOnlyBarHeight
    = Dense
    | ProminentDense


type ContextualActionBar
    = ContextualActionBar
        { title : String
        , actions : List Icon
        , overflow : Bool
        , background : Color
        }


create : Anatomy -> Behavior -> TopAppBar
create anatomy behavior =
    TopAppBar
        { anatomy = anatomy
        , behavior = behavior
        }


unwrap_AppBar : TopAppBar -> { anatomy : Anatomy, behavior : Behavior }
unwrap_AppBar appbar =
    case appbar of
        TopAppBar appbar_ ->
            appbar_


unwrap_Anatomy :
    Anatomy
    ->
        { bar : Bar
        , navigation : Maybe Navigation
        , title : Title
        , actions : List Icon
        , overflow : Bool
        , background : Background
        }
unwrap_Anatomy anatomy =
    case anatomy of
        Anatomy anatomy_ ->
            anatomy_

getHeight : TopAppBar -> Int
getHeight appbar =
    let
        bar =
            unwrap_AppBar appbar
                |> .anatomy
                |> unwrap_Anatomy
                |> .bar
    in
    case bar of
        Height type_ ->
            case type_ of
                Regular ->
                    56

                Prominent ->
                    128

                Desktop Dense ->
                    48

                Desktop ProminentDense ->
                    96


getBlankAnatomy : TopAppBar -> { bar : Bar
        , navigation : Maybe Navigation
        , title : Title
        , actions : List Icon
        , overflow : Bool
        , background : Background
        }
getBlankAnatomy appbar = 
    appbar
    |> unwrap_AppBar
    |> .anatomy
    |> unwrap_Anatomy

view : Style -> TopAppBar -> Element m
view style appbar =
    let
        height_len =
            getHeight appbar
    in
        row
            [ width fill
            , height <| px height_len
            , padding <| 16
            , Background.color style.color.primary
            , Border.shadow {offset = (0,0),size = 1, blur = 4, color = rgb 0 0 0}
            ]
            [viewNavigation style (getBlankAnatomy appbar).navigation
            , viewTitle style (getBlankAnatomy appbar).title
            , viewActions style (getBlankAnatomy appbar).actions (getBlankAnatomy appbar).overflow]

viewNavigation : Style -> Maybe Navigation -> Element m
viewNavigation style mb_nav =
    case mb_nav of
        Nothing -> 
            el 
                [
                    height <| px 24,
                    width <| px 24
                ]
                Element.none
        Just Menu -> 
            el
                [Font.color style.color.on_primary]
                <| viewMaterialIcon "menu"
        Just Up ->
            el
                [Font.color style.color.on_primary]
                <| viewMaterialIcon "up"
        Just Back ->
            el
                [Font.color style.color.on_primary]
                <| viewMaterialIcon "back"

viewMaterialIcon : String -> Element m
viewMaterialIcon name =
    el 
        [Font.family
                [ Font.external
                    { name = "Material Icons"
                    , url = "https://fonts.googleapis.com/css?family=Material+Icons"
                    }
                ]
        ]
        <| text name

viewTitle : Style -> Title -> Element m
viewTitle style title = 
    case title of
        Title text_ ->
            el 
                [paddingXY 32 0
                , Font.color style.color.on_primary
                , Font.letterSpacing style.font.h6.letter_spacing
                , Font.size style.font.h6.size
                , Font.family [Font.typeface style.font.h6.typeface]]
            <| text text_
        Logo img ->
            Element.none

viewActions : Style -> List Icon -> Bool -> Element m
viewActions style icons overflow =
    row
        [Font.color style.color.on_primary]
        <| List.map Internal.Icon.view icons

fixedHeight h = 
    height
        (fill
            |> maximum h
            |> minimum h
        )
