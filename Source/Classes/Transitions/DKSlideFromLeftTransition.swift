//
//  DKSlideFromLeftTransition.swift
//  DevelopmentKit
//
//  Created by Marko Antoljak on 20/04/2023.
//

import Foundation
import UIKit

/// Custom navigation controllet transition that makes navigation controller slide from left to right.
open class DKSlideFromLeftTransition: NSObject, UIViewControllerAnimatedTransitioning {
    
    private let duration: TimeInterval
    
    public init(duration: TimeInterval = 0.2) {
        self.duration = duration
        super.init()
    }
    
    open func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    open func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromVC = transitionContext.viewController(forKey: .from),
              let toView = transitionContext.view(forKey: .to) else {
            return
        }
        let containerView = transitionContext.containerView
        let duration = transitionDuration(using: transitionContext)
        containerView.addSubview(toView)
        toView.frame = CGRect(x: -containerView.bounds.width, y: 0, width: containerView.bounds.width, height: containerView.bounds.height)
        
        UIView.animate(withDuration: duration, animations: {
            fromVC.view.transform = CGAffineTransform(translationX: containerView.bounds.width, y: 0)
            toView.frame = containerView.bounds
        }, completion: { _ in
            fromVC.view.transform = .identity
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
    }
}
