//
//  DKShadowGradientView.swift
//  DevelopmentKit
//
//  Created by Marko Antoljak on 27/04/2023.
//

import UIKit

/// Creates UIView that looks like gradient shadow.
public class DKShadowGradientView: UIView {

    private var gradientLayer: CAGradientLayer?
    private var colors: [CGColor] = []
    
    public init(from colorFrom: CGColor, to colorTo: CGColor) {
        self.colors = [colorFrom, colorTo]
        super.init(frame: .zero)
        setupGradient()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer?.frame = self.bounds
    }
    
    private func setupGradient() {
        backgroundColor = .clear
        isUserInteractionEnabled = false
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = colors
        gradientLayer.locations = [0, 1]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
        layer.addSublayer(gradientLayer)
        self.gradientLayer = gradientLayer
    }

}
