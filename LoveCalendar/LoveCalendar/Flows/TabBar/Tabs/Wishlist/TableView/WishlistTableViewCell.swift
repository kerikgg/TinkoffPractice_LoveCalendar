//
//  WishlistTableViewCell.swift
//  LoveCalendar
//
//  Created by kerik on 25.05.2024.
//

import UIKit

final class WishlistTableViewCell: UITableViewCell {
    private lazy var cellTitle: UILabel = {
        let label = UILabel()
        label.textColor = .labelText
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingMiddle
        label.font = .systemFont(ofSize: 16, weight: .semibold)

        return label
    }()

    private lazy var cellUrl: UILabel = {
        let label = UILabel()
        label.textColor = .systemBlue
        label.numberOfLines = 1
        label.lineBreakMode = .byClipping
        label.font = .systemFont(ofSize: 14, weight: .semibold)

        return label
    }()

    private lazy var shareImageView: UIImageView = {
        let imageView = UIImageView(image: SystemImages.share)
        imageView.contentMode = .scaleAspectFill
        imageView.tintColor = .buttonText

        return imageView
    }()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [cellTitle, cellUrl])
        stackView.axis = .vertical
        stackView.spacing = 10

        return stackView
    }()

    static var reuseIdentifier: String {
        return String(describing: self)
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(stackView)
        contentView.addSubview(shareImageView)
        makeConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension WishlistTableViewCell {
    private func makeConstraints() {
        stackView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(10)
            make.leading.equalToSuperview().inset(20)
        }

        shareImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize(width: 30, height: 30))
            make.trailing.equalToSuperview().inset(20)
        }
    }
}

extension WishlistTableViewCell {
    func configureCell(cellModel: WishListModel) {
        cellTitle.text = cellModel.title
        cellUrl.text = cellModel.url
    }
}
