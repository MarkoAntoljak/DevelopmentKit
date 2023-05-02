//
//  DKPhoneNumberTextField.swift
//  DevelopmentKit
//
//  Created by Marko Antoljak on 27/04/2023.
//

import UIKit

public protocol DKPhoneNumberTextFieldDelegate: AnyObject {
    func countryButtonPressed()
}

open class DKPhoneNumberTextField: UITextField {
    
    public weak var countryDelegate: DKPhoneNumberTextFieldDelegate?
    public override var placeholder: String? {
        didSet { setupPrefixButton() }
    }
    public var fullPhoneNumber: String? {
        guard let prefix = countryCode?.phonePrefix,
              let text = text
        else { return nil }
        return "+\(prefix)\(text)"
    }
    private var prefixText: String?
    private var countryCode: CountryCode? {
        didSet {
            prefixText = "+\(countryCode?.phonePrefix ?? "") \(countryCode?.flag ?? "")"
            setupPrefixButton()
        }
    }
    // MARK: UI
    /// prefix button showing country phone number prefix and country flag
    public var prefixButton = UIButton(type: .system) {
        didSet { setupPrefixButton() }
    }
    private let leftViewContainer = UIView()
    
    // MARK: Init
    
    public init(prefix: String = "1", flag: String = "🇺🇸", placeholder: String = "Enter phone number") {
        super.init(frame: .zero)
        self.prefixText = "+\(prefix) \(flag)"
        self.placeholder = placeholder
        setupViews()
        setupConstraints()
        setupPrefixButton()
    }
    
    required public init?(coder: NSCoder) {
        fatalError()
    }
    
    // MARK: Functions
    
    private func setupViews() {
        backgroundColor = .systemBackground
        keyboardType = .numberPad
        textContentType = .telephoneNumber
        tintColor = .label
        textColor = .label
        layer.cornerRadius = 15
        leftViewContainer.addSubview(prefixButton)
        leftViewMode = .always
        leftView = leftViewContainer
        delegate = self
        prefixButton.addTarget(self, action: #selector(prefixPressed), for: .touchUpInside)
        invalidateIntrinsicContentSize()
    }
    
    private func setupConstraints() {
        leftViewContainer.snp.makeConstraints { make in
            make.width.equalTo(100)
            make.height.equalTo(60)
        }
        prefixButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview().inset(10)
        }
    }
    
    private func setupPrefixButton() {
        prefixButton.setAttributedTitle(NSAttributedString(string: "\(prefixText ?? "")", attributes: [NSAttributedString.Key.font : self.font ?? regular.withSize(14), NSAttributedString.Key.foregroundColor : self.textColor ?? .label]), for: .normal)
    }
    
    public override var intrinsicContentSize: CGSize {
        return CGSize(width: 350, height: 60)
    }
    
    public func setCountryCode(_ countryCode: CountryCode) {
        self.countryCode = countryCode
    }
    
    // MARK: Actions
    
    @objc private func prefixPressed() {
        countryDelegate?.countryButtonPressed()
    }
}

extension DKPhoneNumberTextField: UITextFieldDelegate {
    /// Removes the prefix from the phone number when user selects suggested phone number
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            guard let text = textField.text as NSString? else { return false }
            var resultText = text.replacingCharacters(in: range, with: string)
            guard resultText != " " else { return true }
            resultText = resultText.replacingOccurrences(of: " ", with: "")
            resultText = resultText.replacingOccurrences(of: "(", with: "")
            resultText = resultText.replacingOccurrences(of: ")", with: "")
            resultText = resultText.replacingOccurrences(of: "-", with: "")
            if resultText.hasPrefix("+") {
                if let code = CountryRepository.shared.countryCode(for: resultText) {
                    countryCode = code
                }
            }
        let countryPrefix = "+" + countryCode!.phonePrefix
            if string.hasPrefix(countryPrefix) {
                resultText = resultText.replacingOccurrences(of: countryPrefix, with: "")
            }
            if resultText.rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) != nil {
                return false
            }
            textField.text = resultText
            return false
        }
}

