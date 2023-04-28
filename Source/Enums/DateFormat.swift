//
//  DateFormat.swift
//  DevelopmentKit
//
//  Created by Marko Antoljak on 26/04/2023.
//

import Foundation

/// enum for different date formats
public enum DateFormat: String {
    /// standard timezone format
    case standard = "yyyy-MM-dd'T'HH:mm:ssZ"
    /// 2021-03-24
    case shortAmerican = "MM.dd.yyyy"
    /// 2021-24-03
    case shortEuropian = "dd.MM.yyyy"
    /// 2021-03-24 01:32 PM
    case shortAmericanWithTime = "MM.dd.yyyy hh:mm a"
    /// 2021-24-03 13:32
    case shortEuropianWithTime = "dd.MM.yyyy HH:mm"
    /// 2021-03-24
    case shortInversed = "yyyy.MM.dd"
    /// 2021/03/24
    case shortAmericanSlash = "MM/dd/yyyy"
    /// 2021/24/03
    case shortEuropianSlash = "dd/MM/yyyy"
    /// 2021/03/24
    case shortInversedSlash = "yyyy/MM/dd"
    /// Wednesday, Sep 12, 2018
    case descriptiveWithYear = "EEEE, MMM d, yyyy"
    /// Wednesday, Sep 12
    case longDayShortMonthDay = "EEEE, MMM d"
    /// September 2018
    case longMonthYear = "MMMM yyyy"
    /// Sep 12, 2018
    case mediumMonthDayYear = "MMM d, yyyy"
    /// 1:32 PM
    case hoursMinutesAmerican = "h:mm a"
    /// Sep 12, 1:32 PM
    case monthDateWithTimeAmerican = "MMM d, h:mm a"
    /// Sep 12, 13:32
    case monthDateWithTime = "MMM d, HH:mm"
    /// 01:32:45 PM
    case timeSecondsAmerican = "hh:mm:ss a"
    /// 01:32 PM
    case timeAmerican = "hh:mm a"
    /// 13:32:45
    case timeSeconds = "HH:mm:ss"
    /// 13:32
    case time = "HH:mm"
}
