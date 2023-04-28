//
//  Print.swift
//  DevelopmentKit
//
//  Created by Marko Antoljak on 28/04/2023.
//

import Foundation

/// Prints the error message with function, file and line of code where it is located.
/// Useful for debugging errors.
///
/// ERROR: 'cannot get current country'
/// Function: getCountries()
/// File: CountryRepo.swift
/// Line: 27
///
///
/// - Parameters:
///   - message: The error message.
///   - function: The function where the printError is located in.
///   - file: The file name where the printError is located in.
///   - line: The line of code where the printError is located in.
public func printError(_ message: String, function: String = #function, file: String = #file, line: Int = #line) {
    let fileName = URL(fileURLWithPath: file).lastPathComponent
    print("\n<<<<\nERROR: '\(message)' \nFunction: \(function) \nFile: \(fileName) \nLine: \(line)\n>>>>\n")
}

/// Prints the current code line.
public func printLine(line: Int = #line) {
    print("At line: \(line)")
}
