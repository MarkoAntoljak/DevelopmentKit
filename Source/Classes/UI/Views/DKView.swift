//
//  DKView.swift
//  DevelopmentKit
//
//  Created by Marko Antoljak on 30/04/2023.
//

import Foundation
import UIKit
/// Protocol for adjusting content constraints based on the keyboard show/hide.
public protocol DKKeyboardViewDelegate: AnyObject {
    /// Remake constraints based on the contentInset.
    func adjustContentConstraints(_ contentInset: CGFloat)
}
/// Custom UIView class that handles keyboard notifications and makes handling
/// with content constraints easier when keyboard is shown or hidden.
open class DKKeyboardView: UIView {
    
    public weak var delegate: DKKeyboardViewDelegate?
    
    deinit {
        removeObservers()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        addKeyboardObservers()
    }
    
    required public init?(coder: NSCoder) {
        fatalError()
    }
    /// Adds notification observers that are listening fro keyboard changes.
    /// The keyboardWillShowNotification and keyboardWillHideNotification gets called.
    private func addKeyboardObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShowNotification(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHideNotification(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    /// Gets called when keyboard shows
    @objc private func keyboardWillShowNotification(notification: NSNotification) {
        guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey]
                as? NSValue
        else {
            return
        }
        let keyboardSize = keyboardFrame.cgRectValue.size
        delegate?.adjustContentConstraints(-keyboardSize.height + 20)
        UIView.animate(withDuration: 0.3) { [weak self] in
            self?.layoutIfNeeded()
        }
    }
    /// gets called when keyboard dissmises
    @objc private func keyboardWillHideNotification(notification: NSNotification) {
        delegate?.adjustContentConstraints(-20)
        UIView.animate(withDuration: 0.3) { [weak self] in
            self?.layoutIfNeeded()
        }
    }
}
