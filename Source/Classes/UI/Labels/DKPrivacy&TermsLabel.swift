//
//  DKPrivacy&TermsLabel.swift
//  DevelopmentKit
//
//  Created by Marko Antoljak on 28/04/2023.
//

import UIKit

public class DKPrivacy_TermsLabel: DKLabel, UIGestureRecognizerDelegate {
    
    private var labelText: String
    private var termsTextRange: NSRange
    private var privacyPolicyTextRange: NSRange
    private var labelFont: UIFont
    private var labelTextColor: UIColor
    
    /// Creates a custom label with underlined parts of text that contain clickable content.
    ///
    /// Use the default one to check out how it works.
    ///
    /// To call functions, simply override termsTapped and privacyPolicyTapped functions.
    ///
    /// - Parameters:
    ///   - text: The text of the label. There is a default one.
    ///   - termsTextRange: Character range of the terms of service text. There is a default one.
    ///   - privacyPolicyTextRange: Character range of the privacy policy text. There is a default one.
    ///   - color: The color of the text.
    ///   - background: The background color of the label. The default one is nil.
    ///   - alignment: Text alignment.
    ///   - radius: Corner radius of the background.
    ///   - font: Font of the text.
    ///   - border: Optional border configuration
    ///   - lines: Specific number of lines. Default one is 0.
    public init(text: String = "By continuing, you are agreeing to our Terms of Service and Privacy Policy.",
                termsTextRange: NSRange = NSRange(location: 42, length: 16),
                privacyPolicyTextRange: NSRange = NSRange(location: 63, length: 15),
                color: UIColor = .label,
                background: UIColor? = nil,
                alignment: NSTextAlignment = .center,
                radius: CGFloat = 0.0,
                font: UIFont = semibold.withSize(18),
                border: Border? = nil,
                lines: Int = 0) {
        self.labelText = text
        self.labelTextColor = color
        self.labelFont = font
        self.termsTextRange = termsTextRange
        self.privacyPolicyTextRange = privacyPolicyTextRange
        super.init(nil, attributed: nil, color: color, background: background, alignment: alignment, radius: radius, font: font, border: border, lines: lines)
        setupLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func setupLabel() {
        isUserInteractionEnabled = true
        let attributedString = NSMutableAttributedString(string: labelText)
        attributedString.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: termsTextRange)
        attributedString.addAttribute(.font, value: labelFont, range: termsTextRange)
        attributedString.addAttribute(.foregroundColor, value: labelTextColor, range: termsTextRange)
        attributedString.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: privacyPolicyTextRange)
        attributedString.addAttribute(.font, value: labelFont, range: privacyPolicyTextRange)
        attributedString.addAttribute(.foregroundColor, value: labelTextColor, range: privacyPolicyTextRange)
        self.attributedText = attributedString
    }
    
    private func addTapGestureRecognizer() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(privacyLabelTapped))
        tapGestureRecognizer.delegate = self
        self.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc private func privacyLabelTapped(_ sender: UITapGestureRecognizer) {
        let layoutManager = NSLayoutManager()
        let textContainer = NSTextContainer(size: CGSize(width: bounds.width, height: CGFloat.greatestFiniteMagnitude))
        guard let attributedText = attributedText else {
            print("Attributed Text is nil. Please check your DKPrivacy_TermsLabel propreties!")
            return
        }
        let textStorage = NSTextStorage(attributedString: attributedText)
        layoutManager.addTextContainer(textContainer)
        textStorage.addLayoutManager(layoutManager)
        textContainer.lineFragmentPadding = 0.0
        textContainer.lineBreakMode = self.lineBreakMode
        textContainer.maximumNumberOfLines = self.numberOfLines
        let locationOfTouchInLabel = sender.location(in: self)
        let index = layoutManager.characterIndex(for: locationOfTouchInLabel, in: textContainer, fractionOfDistanceBetweenInsertionPoints: nil)
        if index < attributedText.length {
            if NSLocationInRange(index, termsTextRange) {
                termsTapped()
            } else if NSLocationInRange(index, privacyPolicyTextRange) {
                privacyPolicyTapped()
            }
        }
    }
    
    public func termsTapped() {
        print("Terms Tapped!")
    }
    
    public func privacyPolicyTapped() {
        print("Privacy Policy Tapped!")
    }
    
}
