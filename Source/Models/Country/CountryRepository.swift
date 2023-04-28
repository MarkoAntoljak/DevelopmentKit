//
//  CountryRepository.swift
//  Development Kit
//
//  Created by Marko Antoljak on 19/04/2023.
//

import Foundation

public class CountryRepository {
    
    public static let shared = CountryRepository()
    
    private init() {
        countries = getCountries()
    }

    private var countries: [CountryCode] = []

    private var defaultCountry = CountryCode(
        name: "United States",
        flag: "🇺🇸",
        phonePrefix: "1",
        countryCode: "US"
    )

    public func getCountries() -> [CountryCode] {
        var countries: [CountryCode] = []
        for countryCode in NSLocale.isoCountryCodes {
            let id = NSLocale.localeIdentifier(fromComponents: [NSLocale.Key.countryCode.rawValue: countryCode])
            let name = NSLocale(localeIdentifier: "en_US").displayName(forKey: NSLocale.Key.identifier, value: id)
            let locale = NSLocale(localeIdentifier: id)
            let countryCode = locale.object(forKey: NSLocale.Key.countryCode)
            if let name = name, let countryCode = countryCode as? String,
               let flag = emojiFlag(for: countryCode),
               let extensionCode = NSLocale().extensionCode(countryCode: countryCode)?.replacingOccurrences(of: " ", with: "")
            {
                countries.append(CountryCode(name: name, flag: flag, phonePrefix: extensionCode, countryCode: countryCode))
            }
        }
        countries.sort(by: { $0.name < $1.name })
        return countries
    }

    public func getUserCountry() -> CountryCode? {
        let userLocalRegionCode = Locale.current.regionCode
        let countries = getCountries()
        let country = countries.first { $0.countryCode == userLocalRegionCode }
        return country
    }

    public func countryCode(for phoneNumber: String) -> CountryCode? {
        if phoneNumber.hasPrefix("+1") {
            return CountryCode(name: "United States", flag: "🇺🇸", phonePrefix: "1", countryCode: "US") }
        else {
            return countries.first { phoneNumber.hasPrefix("+" + $0.phonePrefix) }
        }
    }

    public func getDefaultCountry() -> CountryCode {
        return defaultCountry
    }

    private func emojiFlag(for countryCode: String) -> String? {
        let lowercasedCode = countryCode.lowercased()
        guard lowercasedCode.count == 2 else { return nil }
        guard lowercasedCode.unicodeScalars.reduce(true, { accum, scalar in accum && isLowercaseASCIIScalar(scalar) })
        else {return nil}
        let indicatorSymbols = lowercasedCode.unicodeScalars.map { regionalIndicatorSymbol(for: $0) }
        return String(indicatorSymbols.map { Character($0) })
    }

    private func isLowercaseASCIIScalar(_ scalar: Unicode.Scalar) -> Bool {
        return scalar.value >= 0x61 && scalar.value <= 0x7A
    }

    private func regionalIndicatorSymbol(for scalar: Unicode.Scalar) -> Unicode.Scalar {
        precondition(isLowercaseASCIIScalar(scalar))
        return Unicode.Scalar(scalar.value + (0x1F1E6 - 0x61))!
    }
}
