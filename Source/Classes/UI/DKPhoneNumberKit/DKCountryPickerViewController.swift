//
//  DKCountryPickerViewController.swift
//  DevelopmentKit
//
//  Created by Marko Antoljak on 27/04/2023.
//

import UIKit

public protocol DKCountryPickerVCDelegate: AnyObject {
    /// Change the country code of a textField
    func selectedCountry(countryCode: CountryCode)
}
/// Country picker view controller, set delegate to use picked country
public class DKCountryPickerViewController: UIViewController {
    
    public weak var delegate: DKCountryPickerVCDelegate?
    
    private var searchedCountries: [CountryCode] = []
    private var allCountries: [CountryCode] = CountryRepository.shared.getCountries()
    private var isSearching: Bool = false
    private var isEmpty: Bool = false
    
    // MARK: UI
    
    private var tableView = UITableView()
    private let titleView = UILabel()
    private let searchBar = UISearchBar()
    
    // MARK: - Lifecycle
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        configureTitle()
        configureSearchBar()
        configureTableView()
    }
    
    // MARK: Functions
    
    private func configureTitle() {
        title = "Select your country"
    }
    
    private func configureSearchBar() {
        view.backgroundColor = .systemBackground
        view.addSubview(searchBar)
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.centerX.equalToSuperview()
            make.height.equalTo(60)
        }
        searchBar.delegate = self
        searchBar.backgroundColor = .systemBackground
        searchBar.barTintColor = .systemBackground
        let searchTextField = searchBar.searchTextField
        searchTextField.clearButtonMode = .always
        searchTextField.textColor = .label
        searchTextField.tintColor = .label
        searchTextField.placeholder = "Search country"
        searchTextField.backgroundColor = .systemBackground.withAlphaComponent(0.5)
    }
    
    private func configureTableView() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).offset(5)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        tableView.backgroundColor = .systemBackground
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorColor = .separator
        tableView.separatorStyle = .singleLine
        tableView.register(DKCountryCodeCell.self, forCellReuseIdentifier: DKCountryCodeCell.reuseIdentifier)
        tableView.keyboardDismissMode = .onDrag
    }
}

// MARK: - Table view

extension DKCountryPickerViewController: UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching {
            if searchedCountries.isEmpty { isEmpty = true; return 0 }
            else { isEmpty = false; return searchedCountries.count }
        } else { return allCountries.count }
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DKCountryCodeCell.reuseIdentifier, for: indexPath)
                as? DKCountryCodeCell
        else { return UITableViewCell() }
        if isSearching { cell.model = searchedCountries[indexPath.row] }
        else { cell.model = allCountries[indexPath.row] }
        return cell
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isSearching {
            delegate?.selectedCountry(countryCode: searchedCountries[indexPath.row])
            navigationController?.popViewController(animated: true)
        } else {
            delegate?.selectedCountry(countryCode: allCountries[indexPath.row])
            navigationController?.popViewController(animated: true)
        }
        tableView.deselectRow(at: indexPath, animated: true)
        dismiss(animated: true, completion: nil)
    }
    
    public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        isSearching = true
        searchedCountries = allCountries.filter {
            $0.name.lowercased().prefix(searchText.count) == searchText.lowercased()
        }
        if searchText.isEmpty { isSearching = false }
        tableView.reloadData()
    }
    
    public func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.searchTextField.text = nil
        isSearching = false
        tableView.reloadData()
    }
    
}
