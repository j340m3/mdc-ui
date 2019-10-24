module Material.Theme exposing (..)

import Element exposing (Color, rgb255)

type alias Style = 
    {color : ColorTheme
    , font : TypeScale}

type alias ColorTheme = 
    {
        primary : Color,
        primary_variant : Color,
        secondary : Color,
        secondary_variant : Color,
        background : Color,
        surface : Color,
        error : Color,
        on_primary : Color,
        on_secondary : Color,
        on_background : Color,
        on_surface : Color,
        on_error : Color
    }

type alias ScaleCategory =
    {
        typeface : String,
        font: Font,
        size: Int,
        font_case: Case,
        letter_spacing: Float
    }

type Font 
    = Light
    | Regular
    | Medium

type Case
    = Sentence
    | AllCaps

type alias TypeScale 
    = 
    {
        h1 : ScaleCategory,
        h2 : ScaleCategory,
        h3 : ScaleCategory,
        h4 : ScaleCategory,
        h5 : ScaleCategory,
        h6 : ScaleCategory,
        subtitle1 : ScaleCategory,
        subtitle2 : ScaleCategory,
        body1 : ScaleCategory,
        body2 : ScaleCategory,
        button : ScaleCategory,
        caption : ScaleCategory,
        overline : ScaleCategory
    }

defaultStyle : Style
defaultStyle = 
    {
        color = defaultColorTheme,
        font = defaultTypeScale
    }

defaultColorTheme : ColorTheme
defaultColorTheme = 
    {
        primary = rgb255 98 0 238,
        primary_variant = rgb255 55 0 179,
        secondary = rgb255 3 218 198,
        secondary_variant = rgb255 1 135 134,
        background = rgb255 255 255 255,
        surface = rgb255 255 255 255,
        error = rgb255 176 0 32,
        on_primary = rgb255 255 255 255,
        on_secondary = rgb255 0 0 0,
        on_background = rgb255 0 0 0,
        on_surface = rgb255 0 0 0,
        on_error = rgb255 255 255 255
    }

defaultTypeScale : TypeScale
defaultTypeScale = 
    {
        h1 = {
            typeface = "Roboto",
            font = Light,
            size = 96,
            font_case = Sentence,
            letter_spacing = -1.5
        },
        h2 = {
            typeface = "Roboto",
            font = Light,
            size = 96,
            font_case = Sentence,
            letter_spacing = -1.5
        },
        h3 = {
            typeface = "Roboto",
            font = Light,
            size = 96,
            font_case = Sentence,
            letter_spacing = -1.5
        },
        h4 = {
            typeface = "Roboto",
            font = Light,
            size = 96,
            font_case = Sentence,
            letter_spacing = -1.5
        },
        h5 = {
            typeface = "Roboto",
            font = Light,
            size = 96,
            font_case = Sentence,
            letter_spacing = -1.5
        },
        h6 = {
            typeface = "Roboto",
            font = Medium,
            size = 20,
            font_case = Sentence,
            letter_spacing = 0.15
        },
        subtitle1 = {
            typeface = "Roboto",
            font = Light,
            size = 96,
            font_case = Sentence,
            letter_spacing = -1.5
        },
        subtitle2 = {
            typeface = "Roboto",
            font = Light,
            size = 96,
            font_case = Sentence,
            letter_spacing = -1.5
        },
        body1 = {
            typeface = "Roboto",
            font = Light,
            size = 96,
            font_case = Sentence,
            letter_spacing = -1.5
        },
        body2 = {
            typeface = "Roboto",
            font = Light,
            size = 96,
            font_case = Sentence,
            letter_spacing = -1.5
        },
        button = {
            typeface = "Roboto",
            font = Light,
            size = 96,
            font_case = Sentence,
            letter_spacing = -1.5
        },
        caption = {
            typeface = "Roboto",
            font = Light,
            size = 96,
            font_case = Sentence,
            letter_spacing = -1.5
        },
        overline = {
            typeface = "Roboto",
            font = Light,
            size = 96,
            font_case = Sentence,
            letter_spacing = -1.5
        }
    }