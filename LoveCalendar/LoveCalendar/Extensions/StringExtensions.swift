//
//  StringExtensions.swift
//  LoveCalendar
//
//  Created by kerik on 31.05.2024.
//

import Foundation

extension String {
    func declension(number: Int, singular: String, few: String, many: String) -> String {
        let num = number % 100
        if num >= 11 && num <= 19 {
            return many
        }
        switch num % 10 {
        case 1:
            return singular
        case 2, 3, 4:
            return few
        default:
            return many
        }
    }
}
