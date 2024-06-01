//
//  SettingsTableViewCell.swift
//  LoveCalendar
//
//  Created by kerik on 22.05.2024.
//

import UIKit

class SettingsTableViewCell: UITableViewCell {
    private lazy var cellImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.tintColor = .buttonText

        return imageView
    }()

    private lazy var cellTitle: UILabel = {
        let label = UILabel()
        label.textColor = .labelText
        label.font = .systemFont(ofSize: 20, weight: .semibold)

        return label
    }()

    private lazy var arrowImageView: UIImageView = {
        let imageView = UIImageView(image: SystemImages.arrow)
        imageView.contentMode = .scaleAspectFill
        imageView.tintColor = .buttonText

        return imageView
    }()

    static var reuseIdentifier: String {
        return String(describing: self)
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(cellTitle)
        contentView.addSubview(cellImageView)
        contentView.addSubview(arrowImageView)
        makeConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SettingsTableViewCell {
    private func makeConstraints() {
        cellImageView.snp.makeConstraints { make in
            make.top.bottom.leading.equalToSuperview().inset(20)
        }

        cellTitle.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(cellImageView.snp_leadingMargin).offset(30)
        }

        arrowImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(20)
        }
    }
}

extension SettingsTableViewCell {
    func configureCell(cellModel: SettingsModel) {
        cellImageView.image = UIImage(systemName: cellModel.image)
        cellTitle.text = cellModel.title
    }
}
