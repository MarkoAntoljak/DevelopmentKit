//
//  DateExtension.swift
//  DevelopmentKit
//
//  Created by Marko Antoljak on 26/04/2023.
//

import Foundation

public extension Date {
    /// Converts date into string.
    ///
    /// The default format is .shortAmericanWithTime (2021-03-24 01:32 PM).
    ///
    /// - Returns: Date as string in selected format.
    ///
    func asString(_ format: DateFormat = .shortAmericanWithTime) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format.rawValue
        let dateString = dateFormatter.string(from: self)
        return dateString
    }
    /// Calculates time passed from current time using the user's calendar.
    ///
    /// Returns string that shows how much time passed in between current date and date value. Shows years, months, days, hours, minutes.
    /// If the difference is less than 5 minutes it returns "Recently". If the difference is less than 1 minute it returns "Just now".
    ///
    /// Example: 2 hours ago
    ///
    /// - Returns: A String saying how much time passed from current time.
    ///
    func timeAgo() -> String {
        let now = Date()
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: self, to: now)
        if let years = components.year, years > 0 {
            let yearString = years == 1 ? "year" : "years"
            return "\(years) \(yearString) ago"
        } else if let months = components.month, months > 0 {
            let monthString = months == 1 ? "month" : "months"
            return "\(months) \(monthString) ago"
        } else if let days = components.day, days > 0 {
            let dayString = days == 1 ? "day" : "days"
            return "\(days) \(dayString) ago"
        } else if let hours = components.hour, hours > 0 {
            let hourString = hours == 1 ? "hour" : "hours"
            return "\(hours) \(hourString) ago"
        } else if let minutes = components.minute, minutes >= 5 {
            let minuteString = minutes == 1 ? "minute" : "minutes"
            return "\(minutes) \(minuteString) ago"
        } else if let minutes = components.minute, minutes < 5 && minutes > 1 {
            return "Recently"
        } else if let minutes = components.minute, minutes <= 1 {
            return "Just now"
        } else {
            return self.asString()
        }
    }
}
