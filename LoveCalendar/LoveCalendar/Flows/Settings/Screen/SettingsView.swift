//
//  SettingsView.swift
//  LoveCalendar
//
//  Created by kerik on 21.05.2024.
//

import UIKit

protocol SettingsViewDelegate: AnyObject {
    func didTapCell(_ settingsState: SettingsStates)
}

class SettingsView: UIView {
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.backgroundColor = .clear
        tableView.delegate = self
        tableView.isScrollEnabled = false
        tableView.register(
            SettingsSwitchTableViewCell.self,
            forCellReuseIdentifier: SettingsSwitchTableViewCell.reuseIdentifier
        )
        tableView.register(
            SettingsTableViewCell.self,
            forCellReuseIdentifier: SettingsTableViewCell.reuseIdentifier
        )

        return tableView
    }()

    weak var delegate: SettingsViewDelegate?

    init(frame: CGRect, dataSource: SettingsTableViewDataSource) {
        super.init(frame: frame)
        backgroundColor = .background
        self.setDataSource(with: dataSource)
        addSubviews(tableView)
        makeConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SettingsView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case Sections.first.rawValue:
            break
        case Sections.second.rawValue:
            switch indexPath.row {
            case SettingsRows.edit:
                delegate?.didTapCell(.edit)
            default:
                break
            }
        default:
            break
        }
    }
}

extension SettingsView {
    func setDataSource(with dataSource: SettingsTableViewDataSource) {
        tableView.dataSource = dataSource
    }

    private func makeConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
