//
//  IntExtensions.swift
//  LoveCalendar
//
//  Created by kerik on 31.05.2024.
//

import Foundation

extension Int {
    func days() -> String {
        let lastDigit = self % 10
        let lastTwoDigits = self % 100
        var dayString = Strings.Days.many

        if (11...14).contains(lastTwoDigits) {
            dayString = Strings.Days.many
        } else {
            switch lastDigit {
            case 1:
                dayString = Strings.Days.single
            case 2, 3, 4:
                dayString = Strings.Days.few
            default:
                dayString = Strings.Days.many
            }
        }

        return "\(self) \(dayString)"
    }

    func weeks() -> String {
        let lastDigit = self % 10
        let lastTwoDigits = self % 100
        var weekString = Strings.Weeks.many

        if (11...14).contains(lastTwoDigits) {
            weekString = Strings.Weeks.many
        } else {
            switch lastDigit {
            case 1:
                weekString = Strings.Weeks.single
            case 2, 3, 4:
                weekString = Strings.Weeks.few
            default:
                weekString = Strings.Weeks.many
            }
        }

        return "\(self) \(weekString)"
    }

    func months() -> String {
        let lastDigit = self % 10
        let lastTwoDigits = self % 100
        var monthString = Strings.Months.many

        if (11...14).contains(lastTwoDigits) {
            monthString = Strings.Months.many
        } else {
            switch lastDigit {
            case 1:
                monthString = Strings.Months.single
            case 2, 3, 4:
                monthString = Strings.Months.few
            default:
                monthString = Strings.Months.many
            }
        }

        return "\(self) \(monthString)"
    }

    func years() -> String {
        let lastDigit = self % 10
        let lastTwoDigits = self % 100
        var yearString = Strings.Years.many

        if (11...14).contains(lastTwoDigits) {
            yearString = Strings.Years.many
        } else {
            switch lastDigit {
            case 1:
                yearString = Strings.Years.single
            case 2, 3, 4:
                yearString = Strings.Years.few
            default:
                yearString = Strings.Years.many
            }
        }

        return "\(self) \(yearString)"
    }
}
