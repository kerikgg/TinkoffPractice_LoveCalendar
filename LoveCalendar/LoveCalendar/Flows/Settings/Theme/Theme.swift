//
//  Theme.swift
//  LoveCalendar
//
//  Created by kerik on 23.05.2024.
//

import UIKit

enum Theme: Int {
    case light
    case dark

    func getUserInterfaceStyle() -> UIUserInterfaceStyle {
        switch self {
        case.dark:
            return .dark
        case .light:
            return .light
        }
    }
}
