module Material.AppBar exposing (AppBar(..), view)

import Element exposing (..)
import Material.BottomAppBar as BottomAppBar exposing (BottomAppBar)
import Material.TopAppBar as TopAppBar exposing (TopAppBar)
import Material.Theme exposing (..)


type AppBar
    = TopOnly TopAppBar
    | BottomOnly BottomAppBar
    | Both TopAppBar BottomAppBar


view : Style -> AppBar -> Element m -> Element m
view style bar body =
    case bar of
        TopOnly top ->
            column
                [width fill]
                [ TopAppBar.view style top
                , body
                ]

        BottomOnly bottom ->
            column
                [width fill]
                [ body
                , BottomAppBar.view style bottom
                ]

        Both top bottom ->
            column
                [width fill]
                [ TopAppBar.view style top
                , body
                , BottomAppBar.view style bottom
                ]
