module Material.AppBar exposing (AppBar(..), padding, view,Msg)

import Element exposing (Element, column, el, fill, height, none, px, width)
import Material.BottomAppBar as BottomAppBar exposing (BottomAppBar)
import Material.Theme exposing (Style)
import Element.Background as Background
import Material.TopAppBar as TopAppBar exposing (TopAppBar)


type AppBar
    = TopOnly TopAppBar
    | BottomOnly BottomAppBar
    | Both TopAppBar BottomAppBar

type Msg
    = Top TopAppBar.Msg


padding : AppBar -> { top : Int, right : Int, bottom : Int, left : Int }
padding bar =
    case bar of
        TopOnly top ->
            { top = TopAppBar.getHeight top
            , right = 0
            , bottom = 0
            , left = 0
            }

        BottomOnly bottom ->
            { top = 0
            , right = 0
            , bottom = BottomAppBar.getHeight bottom
            , left = 0
            }

        Both top bottom ->
            { top = TopAppBar.getHeight top
            , right = 0
            , bottom = BottomAppBar.getHeight bottom
            , left = 0
            }


view : Style -> AppBar -> Element Msg
view style bar =
    case bar of
        TopOnly top ->
            Element.map Top <|
                el [ Element.below (el [ height (px (TopAppBar.getHeight top)) ] none) ] <|
                    TopAppBar.view style top

        BottomOnly bottom ->
            column
                [ width fill, height fill ]
                [ BottomAppBar.view style bottom
                ]

        Both top bottom ->
            column
                [ height fill, width fill ]
                [ 
                    Element.map Top <|
                    el
                    [ Element.alignTop
                    , width fill
                    , height (px ((TopAppBar.getHeight top)+16))
                    , Background.color style.color.background
                    , Element.inFront <| el [ width fill
                                                  , Element.alignTop
                                                  ] (TopAppBar.view style top)
                    ]
                    none
                , el
                    [ Element.alignBottom
                    , width fill
                    , height (px ((BottomAppBar.getHeight bottom)+16))
                    , Background.color style.color.background
                    , Element.inFront <| el [ width fill
                                                  , Element.alignBottom
                                                  ] (BottomAppBar.view style bottom)
                    ]
                    none
                ]
