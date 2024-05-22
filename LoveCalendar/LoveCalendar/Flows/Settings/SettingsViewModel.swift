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
    var numberOfSection: Int

    init() {
        firstSectionCellModels = [
            .init(image: "moon", title: "Темная тема", isOn: false)
        ]

        secondSectionCellModels = [
            .init(image: "person.circle", title: "Редактировать профиль")
        ]
        numberOfSection = 2
    }

    func toggleDarkTheme(isOn: Bool) {
        // Ваш код для переключения темной темы
        print("Темная тема включена: \(isOn)")
    }
}
