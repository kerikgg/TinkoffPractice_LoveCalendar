//
//  SettingsViewModel.swift
//  LoveCalendar
//
//  Created by kerik on 21.05.2024.
//

import Foundation
import UIKit

class SettingsViewModel {
    var firstSectionCellModels: [SettingsModel]
    var secondSectionCellModels: [SettingsModel]
    private var themeService = ThemeService.shared
    var numberOfSection: Int

    init() {
        firstSectionCellModels = [
            .init(
                image: SystemImages.moon,
                title: Strings.Cells.darkTheme,
                isOn: Bool(truncating: themeService.theme.rawValue as NSNumber)
            )
        ]

        secondSectionCellModels = [
            .init(image: SystemImages.person, title: Strings.Cells.editProfile)
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
