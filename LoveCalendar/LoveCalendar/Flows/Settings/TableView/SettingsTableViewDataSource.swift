//
//  SettingsTableViewDataSource.swift
//  LoveCalendar
//
//  Created by kerik on 21.05.2024.
//

import UIKit

enum Sections: Int, CaseIterable {
    case first
    case second
}

// enum SettingsRows {
//    static let edit = 0
//    static let theme = 1
// }

final class SettingsTableViewDataSource: NSObject, UITableViewDataSource {
    private let viewModel: SettingsViewModel

    init(viewModel: SettingsViewModel) {
        self.viewModel = viewModel
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return Sections.allCases.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case Sections.first.rawValue:
            return viewModel.firstSectionCellModels.count
        case Sections.second.rawValue:
            return viewModel.secondSectionCellModels.count
        default:
            return 0
        }
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch Sections(rawValue: section) {
        case .first:
            return "Внешний вид"
        case .second:
            return "Профиль"
        case .none:
            return nil
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch Sections(rawValue: indexPath.section) {
        case .first:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: SettingsSwitchTableViewCell.reuseIdentifier,
                for: indexPath
            ) as? SettingsSwitchTableViewCell else {
                return UITableViewCell()
            }
            cell.selectionStyle = .none
            cell.configureCell(
                cellModel: viewModel.firstSectionCellModels[indexPath.row],
                switchAction: { [weak self] isOn in
                self?.viewModel.toggleDarkTheme(isOn: isOn)
                }
            )
            return cell
        case .second:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: SettingsTableViewCell.reuseIdentifier,
                for: indexPath
            ) as? SettingsTableViewCell else {
                return UITableViewCell()
            }

            cell.configureCell(cellModel: viewModel.secondSectionCellModels[indexPath.row])
            return cell
        case .none:
            return UITableViewCell()
        }

        func numberOfSections(in tableView: UITableView) -> Int {
            viewModel.numberOfSection
        }
    }
}
