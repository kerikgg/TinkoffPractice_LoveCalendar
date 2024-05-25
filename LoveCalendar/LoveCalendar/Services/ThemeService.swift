//
//  ThemeService.swift
//  LoveCalendar
//
//  Created by kerik on 23.05.2024.
//

import UIKit

final class ThemeService {
    static let shared = ThemeService()

    var theme: Theme {
        get {
            Theme(rawValue: UserDefaults.standard.integer(forKey: "themeKey")) ?? .light
        }
        set {
            UserDefaults.standard.set(newValue.rawValue, forKey: "themeKey")
            updateTheme()
        }
    }

    func updateTheme() {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        else { return }
        guard let window = windowScene.windows.first else { return }
        window.overrideUserInterfaceStyle = theme.getUserInterfaceStyle()
    }
}
