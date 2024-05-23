//
//  SettingsViewModel.swift
//  LoveCalendar
//
//  Created by kerik on 21.05.2024.
//

import Foundation
import UIKit

class SettingsViewModel {
    var firstSectionCellModels: [SettingsCellModel]
    var secondSectionCellModels: [SettingsCellModel]
    private var themeService = ThemeService.shared
    var numberOfSection: Int

    init() {
        firstSectionCellModels = [
            .init(
                image: "moon",
                title: "Темная тема",
                isOn: Bool(truncating: themeService.theme.rawValue as NSNumber)
            )
        ]

        secondSectionCellModels = [
            .init(image: "person.circle", title: "Редактировать профиль")
        ]
        numberOfSection = 2
    }

    func toggleDarkTheme(isOn: Bool) {
        setThemeValue(isOn)
    }

    // MARK: - Theme functions
    func getTheme() -> Theme {
        themeService.theme
    }

    func getThemeValue() -> Bool {
        Bool(truncating: themeService.theme.rawValue as NSNumber)
    }

    func setThemeValue(_ value: Bool) {
        let intValue = value ? 1 : 0
        themeService.theme = Theme(rawValue: intValue) ?? .light
    }
}
