//
//  DKImageView.swift
//  DevelopmentKit
//
//  Created by Marko Antoljak on 28/04/2023.
//

import UIKit

open class DKImageView: UIImageView {

    public init(_ image: UIImage? = nil, scale: UIView.ContentMode = .scaleAspectFit, radius: CGFloat = 15.0, border: Border? = nil, tint: UIColor = .white, background: UIColor? = .clear) {
        super.init(frame: .zero)
        self.image = image
        clipsToBounds = true
        layer.masksToBounds = true
        contentMode = scale
        tintColor = tint
        backgroundColor = background
        layer.cornerRadius = radius
        if let border = border {
            layer.borderColor = border.color
            layer.borderWidth = border.width
        }
    }
    
    required public init?(coder: NSCoder) {
        fatalError()
    }

}
