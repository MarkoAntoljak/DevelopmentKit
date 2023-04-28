//
//  DKExpandCellTransition.swift
//  DevelopmentKit
//
//  Created by Marko Antoljak on 01/04/2023.
//

import Foundation

import UIKit
/// Custom navigation controller transition that expands from setted frame.
///
/// This is mostly used when you want a nice animation transition between tapping on a cell and navigating to new view controller.
open class DKExpandCellTransition: NSObject, UIViewControllerAnimatedTransitioning {
    public let duration: TimeInterval
    public let frame: CGRect

    public init(duration: TimeInterval = 0.3, frame: CGRect) {
        self.duration = duration
        self.frame = frame
        super.init()
    }

    open func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }

    open func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let toView = transitionContext.viewController(forKey: .to)?.view

        guard let toView = toView else {
            transitionContext.completeTransition(false)
            return
        }
        let containerView = transitionContext.containerView
        containerView.addSubview(toView)
        toView.frame = frame
        toView.clipsToBounds = true

        let animationDuration = transitionDuration(using: transitionContext)
        UIView.animate(withDuration: animationDuration, animations: {
            toView.frame = containerView.bounds
            toView.layer.cornerRadius = 0
        }) { _ in
            transitionContext.completeTransition(true)
        }
    }
}
