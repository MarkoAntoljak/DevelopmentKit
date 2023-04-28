//
//  NSObjectExtension.swift
//  DevelopmentKit
//
//  Created by Marko Antoljak on 27/04/2023.
//

import Foundation
import UIKit

public extension NSObject {
    /// Makes user's device vibrate.
    ///
    /// - Parameters:
    ///   - velocity: The hardness of the vibrate. The default one is .soft.
    ///
    ///
    func vibrate(_ velocity: UIImpactFeedbackGenerator.FeedbackStyle = .soft) {
        DispatchQueue.main.async {
            UIImpactFeedbackGenerator(style: velocity).impactOccurred()
        }
    }
    /// Makes user's device vibrate twice.
    ///
    /// - Parameters:
    ///   - velocity: The hardness of the vibrate. The default one is .soft.
    ///
    func vibrateTwice(_ velocity: UIImpactFeedbackGenerator.FeedbackStyle = .soft) {
        DispatchQueue.main.async {
            UIImpactFeedbackGenerator(style: velocity).impactOccurred()
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
            UIImpactFeedbackGenerator(style: velocity).impactOccurred()
        }
    }
    /// Adds the notiifcation observers to current object.
    ///
    /// The order of notification names and functions need to be the same.
    ///
    /// - Parameters:
    ///   - notificationNames: Collection of NSNotification.Name, count of the array is the number of created observers
    ///   - functions: Functions for each observer to be triggered after the notification is received.
    func addNotificationObservers(_ notificationNames: [NSNotification.Name], functions: [Selector]) {
        var i = 0
        for name in notificationNames {
            NotificationCenter.default.addObserver(self, selector: functions[i], name: name, object: nil)
            i += 1
        }
    }
    /// Removes notification observer. Put this function inside deinit.
    func removeObserver() {
        NotificationCenter.default.removeObserver(self)
    }
}
