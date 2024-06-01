//
//  SettingsSwitchTableViewCell.swift
//  LoveCalendar
//
//  Created by kerik on 21.05.2024.
//

import UIKit

class SettingsSwitchTableViewCell: UITableViewCell {
    private lazy var cellImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.tintColor = .buttonText

        return imageView
    }()

    private lazy var cellTitle: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 20, weight: .semibold)

        return label
    }()

    private lazy var cellSwitch: UISwitch = {
        let uiSwitch = UISwitch()
        uiSwitch.addTarget(self, action: #selector(switchValueChanged), for: .valueChanged)
        return uiSwitch
    }()

    static var reuseIdentifier: String {
        return String(describing: self)
    }

    var switchAction: ((Bool) -> Void)?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(cellTitle)
        contentView.addSubview(cellSwitch)
        contentView.addSubview(cellImageView)
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SettingsSwitchTableViewCell {
    private func makeConstraints() {
        cellImageView.snp.makeConstraints { make in
            make.top.bottom.leading.equalToSuperview().inset(20)
        }

        cellTitle.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(cellImageView.snp_leadingMargin).offset(30)
        }

        cellSwitch.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(20)
        }
    }
}

extension SettingsSwitchTableViewCell {
    func configureCell(cellModel: SettingsModel, switchAction: ((Bool) -> Void)?) {
        cellImageView.image = UIImage(systemName: cellModel.image)
        cellTitle.text = cellModel.title
        self.switchAction = switchAction
        guard let isOn = cellModel.isOn else { return }
        cellSwitch.isOn = isOn
        self.switchAction = switchAction
    }

    func configureCell(cellModel: SettingsModel) {
        cellImageView.image = UIImage(systemName: cellModel.image)
        cellTitle.text = cellModel.title
    }

    @objc private func switchValueChanged() {
        switchAction?(cellSwitch.isOn)
    }
}
