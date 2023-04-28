//
//  DKButton.swift
//  DevelopmentKit
//
//  Created by Marko Antoljak on 27/04/2023.
//

import UIKit

/// Custom button class
public class DKButton: UIButton {
    
    private var title: String
    private var attributedTitle: NSAttributedString?
    private var image: UIImage?
    private var background: UIColor
    private var tint: UIColor
    private var buttonRadius: CGFloat
    private var border: Border?
    
    public init(
        title: String = "Button",
        attributedTitle: NSAttributedString? = nil,
        background: UIColor = .blue,
        buttonRadius: CGFloat = 15,
        tint: UIColor = .white,
        image: UIImage? = nil,
        border: Border? = nil) {
            self.attributedTitle = attributedTitle
            self.buttonRadius = buttonRadius
            self.title = title
            self.image = image
            self.background = background
            self.tint = tint
            self.border = border
            super.init(frame: .zero)
            addButtonReactivity()
            setPropreties()
            if #available(iOS 15.0, *) {
                addConfiguration()
            }
        }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // MARK: Functions
    
    private func setPropreties() {
        self.tintColor = tint
        self.backgroundColor = background
        self.layer.cornerRadius = buttonRadius
        self.semanticContentAttribute = .forceRightToLeft
        if let attributedTitle = attributedTitle {
            setAttributedTitle(attributedTitle, for: .normal)
        } else {
            setTitle(title, for: .normal)
        }
        if let image = image {
            setImage(image, for: .normal)
            setImage(image, for: .highlighted)
        } else {
            setImage(nil, for: .normal)
            setImage(nil, for: .highlighted)
        }
        if let border = border {
            layer.borderColor = border.color
            layer.borderWidth = border.width
        }
    }
    
    @available(iOS 15.0, *)
    private func addConfiguration() {
        configuration = UIButton.Configuration.filled()
        configuration?.baseBackgroundColor = backgroundColor
        configuration?.baseForegroundColor = tintColor
        configuration?.cornerStyle = .large
    }
    
    // MARK: Enable or disable button
    
    public func enableButton() {
        self.backgroundColor = background
        self.isEnabled = true
    }
    
    public func disableButton() {
        self.backgroundColor = background.withAlphaComponent(0.3)
        self.isEnabled = false
    }
    
    // MARK: Showing and Hiding Loader
    
    @available(iOS 15.0, *)
    public func showLoader() {
        setAttributedTitle(nil, for: .normal)
        setTitle(nil, for: .normal)
        configuration?.showsActivityIndicator = true
        setImage(nil, for: .normal)
        setImage(nil, for: .highlighted)
    }
    
    @available(iOS 15.0, *)
    public func hideLoader() {
        configuration?.showsActivityIndicator = false
        setPropreties()
    }
    
}
