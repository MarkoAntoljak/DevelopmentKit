//
//  UIViewControllerExtension.swift
//  DevelopmentKit
//
//  Created by Marko Antoljak on 27/04/2023.
//

import Foundation
import UIKit

public extension UIViewController {
    /// Make the navigation bar transparent
    func transparentNavBar() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.barTintColor = .clear
        navigationController?.navigationBar.backgroundColor = .clear
    }
    /// Make the navigation bar background color doesn't change while scrolling
    ///
    /// - Parameters:
    ///   - backgroundColor: The background color of the navigation bar. Default is black.
    ///   - tintColor: The navigation bar elements tint color. Default is white.
    func setOpaqueNavBar(_ backgroundColor: UIColor = .white, _ tintColor: UIColor = .black) {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.backgroundColor = backgroundColor
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        navigationController?.navigationBar.barTintColor = backgroundColor
        navigationController?.navigationBar.tintColor = tintColor
        navigationController?.navigationBar.isTranslucent = false
    }
    /// Presents the UIAlertController with ok action. Sets
    ///
    /// - Parameters:
    ///   - title: Title of the alert.
    ///   - message: Description of the alert.
    ///   - handler: Optional completion when user presses ok action.
    func presentAlert(_ title: String, _ message: String, completion: ((UIAlertAction) -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: completion))
        DispatchQueue.main.async { [weak self] in
            self?.present(alert, animated: true)
        }
    }
    /// Presents the UIAlertController with custom actions.
    ///
    /// - Parameters:
    ///   - style: Style of the alert. Default is .actionSheet
    ///   - title: Title of the alert.
    ///   - message: Description of the alert.
    ///   - actions: All actions for the alert.
    ///   - withCancel: A bool indicating whater to include cancel action or not. Default is true.
    func presentAlert(_ style: UIAlertController.Style = .actionSheet, title: String, message: String, actions: [UIAlertAction]? = nil, withCancel: Bool = true) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: style)
        if let actions = actions {
            actions.forEach({alert.addAction($0)})
        }
        if withCancel {
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        }
        DispatchQueue.main.async { [weak self] in
            self?.present(alert, animated: true)
        }
    }
}
