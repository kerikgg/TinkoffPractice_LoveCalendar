//
//  CalendarTableViewCell.swift
//  LoveCalendar
//
//  Created by kerik on 28.05.2024.
//

import UIKit

final class CalendarTableViewCell: UITableViewCell {
    private lazy var cellImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.tintColor = .buttonText

        return imageView
    }()

    private lazy var cellTitle: UILabel = {
        let label = UILabel()
        label.textColor = .buttonText
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)

        return label
    }()

    private lazy var cellDate: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 16)

        return label
    }()

    static var reuseIdentifier: String {
        return String(describing: self)
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(cellImageView)
        contentView.addSubview(cellTitle)
        contentView.addSubview(cellDate)
        makeConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        cellImageView.layer.cornerRadius = cellImageView.frame.width / 2
    }
}

extension CalendarTableViewCell {
    private func makeConstraints() {
        cellImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(10)
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize(width: 50, height: 50))
        }

        cellTitle.snp.makeConstraints { make in
            make.leading.equalTo(cellImageView.snp_trailingMargin).offset(20)
            make.centerY.equalToSuperview()
            make.trailing.lessThanOrEqualTo(cellDate.snp.leading).offset(-10)
        }

        cellDate.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(10)
            make.centerY.equalToSuperview()
        }
    }
}

extension CalendarTableViewCell {
    func configureCell(cellModel: EventModel) {
        guard let image = UIImage(data: cellModel.image) else { return }
        cellImageView.image = image
        cellTitle.text = cellModel.title
        cellDate.text = cellModel.date.toLocalTimeZoneString()
    }
}
