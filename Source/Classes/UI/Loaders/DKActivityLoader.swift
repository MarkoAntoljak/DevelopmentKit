//
//  DKActivityLoader.swift
//  DevelopmentKit
//
//  Created by Marko Antoljak on 28/04/2023.
//

import UIKit

open class DKActivityLoader: UIActivityIndicatorView {

    public init(tint: UIColor = .white, background: UIColor = .clear, radius: CGFloat = 10.0, border: Border? = nil) {
        super.init(frame: .zero)
        tintColor = tintColor
        backgroundColor = background
        layer.cornerRadius = radius
        if let border = border {
            layer.borderColor = border.color
            layer.borderWidth = border.width
        }
    }

    required public init(coder: NSCoder) {
        fatalError()
    }
    
}
