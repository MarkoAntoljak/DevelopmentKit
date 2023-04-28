//
//  DKLabel.swift
//  DevelopmentKit
//
//  Created by Marko Antoljak on 28/04/2023.
//

import UIKit

open class DKLabel: UILabel {

    public init(
        _ text: String?,
        attributed: NSAttributedString? = nil,
        color: UIColor = .label,
        background: UIColor? = nil,
        alignment: NSTextAlignment = .center,
        radius: CGFloat = 0.0,
        font: UIFont = semibold.withSize(18),
        border: Border? = nil,
        lines: Int = 0
    ) {
        super.init(frame: .zero)
        if let text = text {
            self.text = text
            self.textColor = color
            self.font = font
        }
        self.attributedText = attributed
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
