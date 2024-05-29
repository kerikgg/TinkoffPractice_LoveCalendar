//
//  AlbumCollectionViewCell.swift
//  LoveCalendar
//
//  Created by kerik on 29.05.2024.
//

import UIKit

final class AlbumCollectionViewCell: UICollectionViewCell {
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.textColor = .white
        label.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        label.textAlignment = .center
        return label
    }()

    static var reuseIdentifier: String {
        return String(describing: self)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
        makeConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension AlbumCollectionViewCell {
    private func makeConstraints() {
        imageView.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
        }

        titleLabel.snp.makeConstraints { make in
            make.height.equalTo(30)
            make.leading.trailing.bottom.equalTo(contentView)
        }
    }
}

extension AlbumCollectionViewCell {
    func configure(with event: EventModel) {
        imageView.image = UIImage(data: event.image)
        if !event.title.isEmpty {
            titleLabel.text = event.title
        } else {
            titleLabel.text = event.date.toLocalTimeZoneString()
        }
    }
}
