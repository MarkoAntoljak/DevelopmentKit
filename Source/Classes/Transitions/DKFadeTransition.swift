//
//  DKFadeTransition.swift
//  DevelopmentKit
//
//  Created by Marko Antoljak on 01/04/2023.
//

import Foundation
import UIKit

/// Custom navigation transition that fades out the current navigation controller.
public class DKFadeTransition: NSObject, UIViewControllerAnimatedTransitioning {
    private let duration: TimeInterval
    
    public init(duration: TimeInterval = 0.2) {
        self.duration = duration
        super.init()
    }
    
    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let fromView = transitionContext.viewController(forKey: .from)?.view
        let toView = transitionContext.viewController(forKey: .to)?.view
        guard let fromVCView = fromView, let toVCView = toView else {
            transitionContext.completeTransition(false)
            return
        }
        let containerView = transitionContext.containerView
        containerView.addSubview(toVCView)
        toVCView.alpha = 0
        
        let animationDuration = transitionDuration(using: transitionContext)
        UIView.animate(withDuration: animationDuration, animations: {
            toVCView.alpha = 1
            fromVCView.alpha = 0
        }) { _ in
            fromVCView.alpha = 1
            transitionContext.completeTransition(true)
        }
    }
}

