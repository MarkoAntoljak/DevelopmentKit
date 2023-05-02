//
//  DKCodeSMSTextField.swift
//  DevelopmentKit
//
//  Created by Marko Antoljak on 3/8/23.
//

import UIKit

open class DKCodeSMSTextField: UITextField, UITextFieldDelegate {
    
    // MARK: Attributes
    
    public var didEnterLastDigit: ((String) -> Void)?
    public var fieldBackground: UIColor
    public var fieldTextColor: UIColor
    public var fieldTextFont: UIFont
    
    private var defaultCharacter: String
    private var codeCount: Int
    private var digitLabels = [UILabel]()
    private lazy var tapRecognizer: UITapGestureRecognizer = {
        let recognizer = UITapGestureRecognizer()
        recognizer.addTarget(self, action: #selector(becomeFirstResponder))
        return recognizer
    }()
    
    // MARK: Init

    public init(placeholderCharacter: String = "", codeCount: Int = 6, fieldBackground: UIColor = .secondarySystemBackground, fieldTextColor: UIColor = .label, fieldTextFont: UIFont = heavy.withSize(50)) {
        self.fieldBackground = fieldBackground
        self.fieldTextFont = fieldTextFont
        self.fieldTextColor = fieldTextColor
        self.defaultCharacter = placeholderCharacter
        self.codeCount = codeCount
        super.init(frame: .zero)
        configureStackView()
        configureTextField()
    }
    
    required public init?(coder: NSCoder) {
        fatalError()
    }
    
    // MARK: Reset all text

    public func resetText() {
        for label in digitLabels {
            label.text = defaultCharacter
        }
        text = nil
    }
    
    // MARK: Configuration
    
    private func configureStackView() {
        let labelsStackView = createLabelsStackView(with: codeCount)
        addSubview(labelsStackView)
        labelsStackView.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        addGestureRecognizer(tapRecognizer)
    }
    
    private func configureTextField() {
        tintColor = .clear
        textColor = .clear
        keyboardType = .numberPad
        textContentType = .oneTimeCode
        addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        delegate = self
    }
    
    private func createLabelsStackView(with count: Int) -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        for _ in 1...count {
            let label = UILabel()
            label.textAlignment = .center
            label.font = fieldTextFont
            label.layer.masksToBounds = true
            label.layer.cornerRadius = 10
            label.textColor = fieldTextColor
            label.backgroundColor = fieldBackground
            label.isUserInteractionEnabled = true
            label.text = defaultCharacter
            stackView.addArrangedSubview(label)
            digitLabels.append(label)
        }
        return stackView
    }
    
    // MARK: Text editing
    @objc
    private func textDidChange() {
        vibrate()
        guard let text = self.text, text.count <= digitLabels.count else { return }
        for i in 0 ..< digitLabels.count {
            let currentLabel = digitLabels[i]
            
            if i < text.count {
                let index = text.index(text.startIndex, offsetBy: i)
                currentLabel.text = String(text[index])
            } else {
                currentLabel.text = defaultCharacter
            }
        }
        if text.count == digitLabels.count {
            didEnterLastDigit?(text)
        }
    }
    
    // MARK: Text Field Delegate
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let characterCount = textField.text?.count else { return false }
        return characterCount < digitLabels.count || string == ""
    }
    
}
