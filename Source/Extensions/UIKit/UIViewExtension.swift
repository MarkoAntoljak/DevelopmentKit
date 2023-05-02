//
//  UIViewExtension.swift
//  DevelopmentKit
//
//  Created by Marko Antoljak on 26/04/2023.
//

import Foundation
import UIKit
import SkeletonView
import SnapKit

public extension UIView {
    /// Adds skeleton animation to view.
    ///
    /// - Parameters:
    ///   - show: Bool indicating to show or hide the skeleton animation.
    ///
    func skeleton(_ show: Bool) {
        isSkeletonable = show
        self.skeletonCornerRadius = 15
        let animation = SkeletonAnimationBuilder().makeSlidingAnimation(withDirection: .topLeftBottomRight, duration: 1)
        let gradient = SkeletonGradient(baseColor: UIColor.lightGray.withAlphaComponent(0.7))
        if show { showAnimatedGradientSkeleton(usingGradient: gradient, animation: animation) }
        else { hideSkeleton(reloadDataAfter: true) }
    }
    /// View animation when user presses the screen.
    @objc func touchDown() {
        UIView.animate(
            withDuration: 0.1,
            animations: { [weak self] in
                self?.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            }
        )
    }
    /// View animation when user releases the screen.
    @objc func touchUp() {
        UIView.animate(
            withDuration: 0.1,
            animations: { [weak self] in
                self?.transform = CGAffineTransform.identity
            }
        )
    }
    /// Adds reactivity to UIView when pressed.
    /// Add this to function when user touches the UIView class.
    func addViewReactivity() {
        touchDown()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [weak self] in
            self?.touchUp()
        }
    }
    /// Sets constraints on width and height of a UIView.
    ///
    /// - Parameters:
    ///   - width: Width value.
    ///   - height: Height value.
    ///
    @objc func setSize(width: CGFloat, height: CGFloat) {
        snp.makeConstraints { make in
            make.width.equalTo(width)
            make.height.equalTo(height)
        }
    }
    /// Adds all memebers of an array to the view.
    ///
    /// - Parameters:
    ///   - subviews: An array of UIViews to be added.
    func addSubviews(_ subviews: [UIView]) {
        for view in subviews {
            addSubview(view)
        }
    }
    /// Makes view a circle.
    /// - Parameters:
    ///   - radius: Optional radius if you want to set specfiic corner radius.
    func round(_ radius: CGFloat = 2.0) {
        self.layer.cornerRadius = self.frame.width / radius
    }
    /// Adds shadow to a view
    ///
    /// - Parameters:
    ///   - color: Color of the shadow.
    ///   - radius: Radius of the shadow.
    ///   - offset: Offset x,y of the shadow
    ///   - opacity: Shadow opacity
    func addShadow(
        color: UIColor = .black,
        radius: CGFloat = 4,
        offset: CGSize = CGSize(width: 4, height: 4),
        opacity: Float = 0.5
    ) {
        layer.shadowColor = color.cgColor
        layer.shadowOffset = offset
        layer.shadowRadius = radius
        layer.shadowOpacity = opacity
        layer.masksToBounds = false
    }
    /// Ends editing for the current view
    func endEditingOnTap() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapCurrentView))
        isUserInteractionEnabled = true
        addGestureRecognizer(tap)
    }
    /// Gets called when user tapps on screen
    @objc private func didTapCurrentView() {
        endEditing(true)
    }
}
