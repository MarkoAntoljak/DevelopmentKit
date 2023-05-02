//
//  Other.swift
//  DevelopmentKit
//
//  Created by Marko Antoljak on 30/04/2023.
//

import Foundation
import UIKit

public func attributedString(_ title: String, font: UIFont, color: UIColor) -> NSAttributedString {
    NSAttributedString(string: title, attributes: [NSAttributedString.Key.font : font, NSAttributedString.Key.foregroundColor : color])
}
