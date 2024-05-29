//
//  DateExtensions.swift
//  LoveCalendar
//
//  Created by kerik on 29.05.2024.
//

import Foundation

extension Date {
    func toLocalTimeZoneString(format: String = "dd.MM.yyyy") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.timeZone = TimeZone.current
        return dateFormatter.string(from: self)
    }
}
