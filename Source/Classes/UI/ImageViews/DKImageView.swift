//
//  DKImageView.swift
//  DevelopmentKit
//
//  Created by Marko Antoljak on 28/04/2023.
//

import UIKit

public class DKImageView: UIImageView {

    public init(_ image: UIImage? = nil, scale: UIView.ContentMode = .scaleAspectFill, radius: CGFloat = 15.0, border: Border? = nil) {
        super.init(image: image)
        clipsToBounds = true
        contentMode = scale
        layer.masksToBounds = true
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
