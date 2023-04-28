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

public class DKPhoneNumberTextField: UITextField {
    
    public weak var countryDelegate: DKPhoneNumberTextFieldDelegate?
    public var countryCode: CountryCode? {
        didSet {
            numberPrefix = "+\(countryCode?.phonePrefix ?? "") \(countryCode?.flag ?? "")"
            setupContent()
        }
    }
    public override var placeholder: String? {
        didSet { setupContent() }
    }
    private var numberPrefix: String?
    
    // MARK: UI
    
    private var prefixButton = UIButton(type: .system)
    private let leftViewContainer = UIView()
    
    // MARK: Init
    
    public convenience init(prefix: String? = "1", flag: String? = "🇺🇸", placeholder: String? = "Enter phone number") {
        self.init()
        self.numberPrefix = prefix
        numberPrefix?.append(contentsOf: " \(flag ?? "")")
        self.placeholder = placeholder
        countryCode = CountryRepository.shared.getUserCountry() ??
        CountryRepository.shared.getDefaultCountry()
        setupViews()
        setupConstraints()
        setupContent()
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
        prefixButton.addTarget(self, action: #selector(prefixPressed), for: .touchUpInside)
        prefixButton.tintColor = .label
        leftViewMode = .always
        leftView = leftViewContainer
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
    
    private func setupContent() {
        prefixButton.setTitle("\(numberPrefix ?? "")", for: .normal)
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
