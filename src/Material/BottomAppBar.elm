module Material.BottomAppBar exposing (..)

import Element exposing (..)
import Html exposing (Html)
import Internal.Icon exposing (Icon)
import Internal.Image exposing (Image)
import Internal.FAB

import Material.Theme exposing (..)


type BottomAppBar
    = BottomAppBar
        { anatomy : Anatomy
        , behavior : Behavior
        }


type Anatomy
    = Anatomy
        { navigation : Maybe Navigation
        , fab : Maybe FAB
        , actions : List Icon
        , overflow : Bool
        , background : Background
        }

type FAB =
    FAB
    {
        fab : Internal.FAB.FAB
        , positioning : Positioning
        , display : Display
    }

type Positioning
    = Centered 
    | End

type Display
    = Overlapping
    | Inset

type Background
    = Color Color
    | Image Image


type Behavior
    = Behavior
        { scolling : ScrollingBehavior
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
    = Bar { height : BarHeight }


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


view : Style ->  BottomAppBar -> Element m
view style appbar =
    text "Hello World"
