//
//  Fonts.swift
//  DevelopmentKit
//
//  Created by Marko Antoljak on 27/04/2023.
//

import Foundation
import UIKit

/// Creates a font based on the weight and systemDesign type
public func createFont(_ type: UIFont.Weight, _ fontDescriptor: UIFontDescriptor.SystemDesign = .default) -> UIFont {
    return UIFont(descriptor:
                    UIFont.systemFont(
                        ofSize: UIFont.labelFontSize, weight: type)
                        .fontDescriptor.withDesign(fontDescriptor) ?? .preferredFontDescriptor(withTextStyle: .body),
                  size: UIFont.labelFontSize)
}
/// Creates an italic font based on the weight and systemDesign type
public func createItalicFont(weight: UIFont.Weight, _ fontDescriptor: UIFontDescriptor.SystemDesign = .default) -> UIFont {
    var fontName: String
    switch fontDescriptor {
    case .rounded:
        fontName = "SFProRounded-Italic"
    case .monospaced:
        fontName = "SFMono-Italic"
    case .serif:
        fontName = "SFProSerif-Italic"
    case .default:
        fontName = "SFProText-Italic"
    default:
        fontName = "SFProText-Italic"
        break
    }
    let descriptor = UIFontDescriptor(name: fontName, size: UIFont.labelFontSize)
        .addingAttributes([UIFontDescriptor.AttributeName.traits: [UIFontDescriptor.TraitKey.weight: weight]])
    return UIFont(descriptor: descriptor, size: UIFont.labelFontSize)
}
// FONT CONSTANTS
/// SF Pro Bold
///
/// To specify the fontSize use .withSize()
public let bold: UIFont = createFont(.bold, .default)
/// SF Pro Black
///
/// To specify the fontSize use .withSize()
public let black: UIFont = createFont(.black, .default)
/// SF Pro Heavy
///
/// To specify the fontSize use .withSize()
public let heavy: UIFont = createFont(.heavy, .default)
/// SF Pro Thin
///
/// To specify the fontSize use .withSize()
public let thin: UIFont = createFont(.thin, .default)
/// SF Pro UltraLight
///
/// To specify the fontSize use .withSize()
public let ultraLight: UIFont = createFont(.ultraLight, .default)
/// SF Pro Light
///
/// To specify the fontSize use .withSize()
public let light: UIFont = createFont(.light, .default)
/// SF Pro Medium
///
/// To specify the fontSize use .withSize()
public let medium: UIFont = createFont(.medium, .default)
/// SF Pro Regular
///
/// To specify the fontSize use .withSize()
public let regular: UIFont = createFont(.regular, .default)
/// SF Pro Semibold
///
/// To specify the fontSize use .withSize()
public let semibold: UIFont = createFont(.semibold, .default)
/// SF Pro Black Italic
///
/// To specify the fontSize use .withSize()
public let boldItalic: UIFont =  createItalicFont(weight: .bold, .default)
/// SF Pro heavy Italic
///
/// To specify the fontSize use .withSize()
public let heavyItalic: UIFont = createItalicFont(weight: .heavy, .default)
/// SF Pro Black Italic
///
/// To specify the fontSize use .withSize()
public let blackItalic: UIFont = createItalicFont(weight: .black, .default)
/// SF Pro Light Italic
///
/// To specify the fontSize use .withSize()
public let lightItalic: UIFont = createItalicFont(weight: .light, .default)
/// SF Pro Thin Italic
///
/// To specify the fontSize use .withSize()
public let thinItalic: UIFont = createItalicFont(weight: .thin, .default)
/// SF Pro UltraLight Italic
///
/// To specify the fontSize use .withSize()
public let ultraLightItalic: UIFont = createItalicFont(weight: .ultraLight, .default)
/// SF Pro Medium Italic
///
/// To specify the fontSize use .withSize()
public let mediumItalic: UIFont = createItalicFont(weight: .medium, .default)
/// SF Pro Regular Italic
///
/// To specify the fontSize use .withSize()
public let regularItalic: UIFont = createItalicFont(weight: .regular, .default)
/// SF Pro Semibold Italic
///
/// To specify the fontSize use .withSize()
public let semiboldItalic: UIFont = createItalicFont(weight: .semibold, .default)
/// SF Pro Rounded Bold
///
/// To specify the fontSize use .withSize()
public let roundedBold: UIFont = createFont(.bold, .rounded)
/// SF Pro Rounded Black
///
/// To specify the fontSize use .withSize()
public let roundedBlack: UIFont = createFont(.black, .rounded)
/// SF Pro Rounded Heavy
///
/// To specify the fontSize use .withSize()
public let roundedHeavy: UIFont = createFont(.heavy, .rounded)
/// SF Pro Rounded Thin
///
/// To specify the fontSize use .withSize()
public let roundedThin: UIFont = createFont(.thin, .rounded)
/// SF Pro Rounded UltraLight
///
/// To specify the fontSize use .withSize()
public let roundedUltraLight: UIFont = createFont(.ultraLight, .rounded)
/// SF Pro Rounded Light
///
/// To specify the fontSize use .withSize()
public let roundedLight: UIFont = createFont(.light, .rounded)
/// SF Pro Rounded Medium
///
/// To specify the fontSize use .withSize()
public let roundedMedium: UIFont = createFont(.medium, .rounded)
/// SF Pro Rounded Regular
///
/// To specify the fontSize use .withSize()
public let roundedRegular: UIFont = createFont(.regular, .rounded)
/// SF Pro Rounded Semibold
///
/// To specify the fontSize use .withSize()
public let roundedSemibold: UIFont = createFont(.semibold, .rounded)
/// SF Pro Rounded Bold Italic
///
/// To specify the fontSize use .withSize()
public let roundedBoldItalic: UIFont = createItalicFont(weight: .bold, .rounded)
/// SF Pro Rounded Heavy Italic
///
/// To specify the fontSize use .withSize()
public let roundedHeavyItalic: UIFont = createItalicFont(weight: .heavy, .rounded)
/// SF Pro Rounded Black Italic
///
/// To specify the fontSize use .withSize()
public let roundedBlackItalic: UIFont = createItalicFont(weight: .black, .rounded)
/// SF Pro Rounded Light Italic
///
/// To specify the fontSize use .withSize()
public let roundedLightItalic: UIFont = createItalicFont(weight: .light, .rounded)
/// SF Pro Rounded Thin Italic
///
/// To specify the fontSize use .withSize()
public let roundedThinItalic: UIFont =  createItalicFont(weight: .thin, .rounded)
/// SF Pro Rounded UltraLight Italic
///
/// To specify the fontSize use .withSize()
public let roundedUltraLightItalic: UIFont = createItalicFont(weight: .ultraLight, .rounded)
/// SF Pro Rounded Medium Italic
///
/// To specify the fontSize use .withSize()
public let roundedMediumItalic: UIFont = createItalicFont(weight: .medium, .rounded)
/// SF Pro Rounded Regular Italic
///
/// To specify the fontSize use .withSize()
public let roundedRegularItalic: UIFont = createItalicFont(weight: .regular, .rounded)
/// SF Pro Rounded Semibold Italic
///
/// To specify the fontSize use .withSize()
public let roundedSemiboldItalic: UIFont = createItalicFont(weight: .semibold, .rounded)


