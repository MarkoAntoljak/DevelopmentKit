//
//  DKLabel.swift
//  DevelopmentKit
//
//  Created by Marko Antoljak on 28/04/2023.
//

import UIKit

open class DKLabel: UILabel {

    public init(
        text: String,
        color: UIColor = .label,
        font: UIFont = semibold.withSize(18),
        alignment: NSTextAlignment = .center,
        background: UIColor? = .clear,
        radius: CGFloat = 0.0,
        border: Border? = nil,
        lines: Int = 0
    ) {
        super.init(frame: .zero)
        self.attributedText = attributedString(text, font: font, color: color)
        self.backgroundColor = background
        self.numberOfLines = lines
        self.textAlignment = alignment
        self.layer.cornerRadius = radius
        if let border = border {
            layer.borderColor = border.color
            layer.borderWidth = border.width
        }
    }

    required public init?(coder: NSCoder) {
        fatalError()
    }
}
