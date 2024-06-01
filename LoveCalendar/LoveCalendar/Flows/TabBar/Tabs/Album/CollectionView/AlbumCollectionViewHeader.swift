//
//  AlbumCollectionViewHeader.swift
//  LoveCalendar
//
//  Created by kerik on 30.05.2024.
//

import UIKit

final class AlbumCollectionViewHeader: UICollectionReusableView {
    static var reuseIdentifier: String {
        return String(describing: self)
    }

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textColor = .labelText
        
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(8)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
