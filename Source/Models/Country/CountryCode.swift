//
//  CountryCode.swift
//  DevelopmentKit
//
//  Created by Marko Antoljak on 19/04/2023.
//

import Foundation

public class CountryCode {
    
    public var name: String
    
    public var flag: String
    
    public var phonePrefix: String
    
    public var countryCode: String
    
    public init(name: String, flag: String, phonePrefix: String, countryCode: String) {
        self.name = name
        self.flag = flag
        self.phonePrefix = phonePrefix
        self.countryCode = countryCode
    }

}
