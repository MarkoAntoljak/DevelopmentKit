//
//  StringExtension.swift
//  DevelopmentKit
//
//  Created by Marko Antoljak on 26/04/2023.
//

import Foundation

public extension String {
    /// Convert string to a date object.
    ///
    /// Converts string into a date object, if there is an error it returns nil and
    /// prints the error.
    ///
    /// - Parameters:
    ///   - format: The format of a string which is converted. You can specify yours or the default is used (yyyy-MM-dd HH:mm:ss).
    ///
    /// - Returns: An optional date.
    ///
    func getDate(_ format: String = DateFormat.standard.rawValue, customFormat: String?) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        guard let date = dateFormatter.date(from: self) else {
            print("Cannot convert to date! Check input string...")
            return nil
        }
        return date
    }
    /// This method takes an integer index `i` as a parameter and returns the single-character substring at that index.
    subscript (i: Int) -> String {
        return self[i ..< i + 1]
    }
    /// Takes a range of integer indices `r` as a parameter and returns the substring corresponding to that range of indices.
    subscript (r: Range<Int>) -> String {
        let range = Range(uncheckedBounds: (lower: max(0, min(count, r.lowerBound)),
                                            upper: min(count, max(0, r.upperBound))))
        let start = index(startIndex, offsetBy: range.lowerBound)
        let end = index(start, offsetBy: range.upperBound - range.lowerBound)
        return String(self[start ..< end])
    }
    /// Removes white spaces and new lines from a string
    ///
    /// - Returns: A string without whitespaces and new lines
    func trimmed() -> String {
        return trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
