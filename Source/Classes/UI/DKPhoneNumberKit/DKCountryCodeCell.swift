//
//  DKCountryCodeCell.swift
//  DevelopmentKit
//
//  Created by Marko Antoljak on 27/04/2023.
//

import Foundation
import UIKit

open class DKCountryCodeCell: UITableViewCell {
    
    public static let reuseIdentifier = "CountryCodeCell"
    public var model: CountryCode? {
        didSet { configureViews() }
    }
    
    // MARK: UI
    
    open var titleLabel: UILabel = {
        let label = UILabel()
        label.font = semibold.withSize(16)
        label.textColor = .label
        return label
    }()
    open var countryCodeLabel: UILabel = {
        let label = UILabel()
        label.font = bold.withSize(16)
        label.textColor = .label
        return label
    }()
    
    // MARK: Functions
    
    private func configureViews() {
        backgroundColor = .systemBackground
        addSubview(titleLabel)
        addSubview(countryCodeLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.equalToSuperview().offset(20)
        }
        countryCodeLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(30)
        }
        guard let model = model else { return }
        titleLabel.text = "\(model.flag) \(model.name)"
        countryCodeLabel.text = "+\(model.phonePrefix)"
    }
}

