//
//  DKCodeSMSTextField.swift
//  DevelopmentKit
//
//  Created by Marko Antoljak on 3/8/23.
//

import UIKit

public class DKCodeSMSTextField: UITextField, UITextFieldDelegate {
    
    // MARK: Attributes
    
    public var didEnterLastDigit: ((String) -> Void)?
    
    private var defaultCharacter: String
    private var codeCount: Int
    
    private var digitLabels = [UILabel]()
    
    private lazy var tapRecognizer: UITapGestureRecognizer = {
        let recognizer = UITapGestureRecognizer()
        recognizer.addTarget(self, action: #selector(becomeFirstResponder))
        return recognizer
    }()
    
    // MARK: Init

    public init(placeholderCharacter: String = "", codeCount: Int = 6) {
        self.defaultCharacter = placeholderCharacter
        self.codeCount = codeCount
        super.init(frame: .zero)
        configureStackView()
        configureTextField()
    }
    
    required init?(coder: NSCoder) {
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
            label.font = heavy.withSize(50)
            label.layer.masksToBounds = true
            label.layer.cornerRadius = 10
            label.textColor = .label
            label.backgroundColor = .secondarySystemBackground
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
