//
//  UIFont+Extension.swift
//  weatherBox2
//
//  Created by Ścibor Budkowski on 27/04/2021.
//

import UIKit

extension UIFont {
    
    public enum AvenirFontType: String {
        case oblique = "Avenir-Oblique"
        case heavyOblique = "Avenir-HeavyOblique"
        case heavy = "Avenir-Heavy"
        case blackOblique = "Avenir-BlackOblique"
        case bookOblique = "Avenir-BookOblique"
        case roman = "Avenir-Roman"
        case medium = "Avenir-Medium"
        case black = "Avenir-Black"
        case light = "Avenir-Light"
        case mediumOblique = "Avenir-MediumOblique"
        case book = "Avenir-Book"
        case lightOblique = "Avenir-LightOblique"
    }
    
    public enum AvenirNextFontType: String {
        case medium = "AvenirNext-Medium"
        case demiBoldItalic = "AvenirNext-DemiBoldItalic"
        case demiBold = "AvenirNext-DemiBold"
        case heavyItalic = "AvenirNext-HeavyItalic"
        case regular = "AvenirNext-Regular"
        case italic = "AvenirNext-Italic"
        case mediumItalic = "AvenirNext-MediumItalic"
        case ultraLightItalic = "AvenirNext-UltraLightItalic"
        case boldItalic = "AvenirNext-BoldItalic"
        case heavy = "AvenirNext-Heavy"
        case bold = "AvenirNext-Bold"
        case ultraLight = "AvenirNext-UltraLight"
    }
    
    static func Avenir(_ type: AvenirFontType = .book, size: CGFloat = UIFont.systemFontSize) -> UIFont {
        return UIFont(name: type.rawValue, size: size)!
    }
    
    static func AvenirNext(_ type: AvenirNextFontType = .regular, size: CGFloat = UIFont.systemFontSize) -> UIFont {
        return UIFont(name: type.rawValue, size: size)!
    }
}
