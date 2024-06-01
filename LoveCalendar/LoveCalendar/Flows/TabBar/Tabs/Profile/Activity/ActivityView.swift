//
//  ActivityView.swift
//  LoveCalendar
//
//  Created by kerik on 01.06.2024.
//

import UIKit
import SnapKit

protocol ActivityViewDelegate: AnyObject {
    func didTapCloseButton()
}

final class ActivityView: UIView {
    weak var delegate: ActivityViewDelegate?

    private lazy var activityImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()

    private lazy var activityTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = .black
        return label
    }()

    private lazy var activityDescriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = .gray
        label.numberOfLines = 0
        return label
    }()

    private lazy var closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("X", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        button.setTitleColor(.black, for: .normal)
        
        let action = UIAction { [weak self] _ in
            self?.delegate?.didTapCloseButton()
        }
        button.addAction(action, for: .touchUpInside)

        return button
    }()

    var onClose: (() -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        backgroundColor = .white
        layer.cornerRadius = 10
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.1
        layer.shadowOffset = CGSize(width: 0, height: 5)
        layer.shadowRadius = 10

        addSubviews(activityImageView, activityTitleLabel, activityDescriptionLabel, closeButton)
        makeConstraints()
    }

    private func makeConstraints() {
        activityImageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(150)
        }

        activityTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(activityImageView.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(8)
        }

        activityDescriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(activityTitleLabel.snp.bottom).offset(4)
            make.leading.trailing.equalToSuperview().inset(8)
            make.bottom.equalToSuperview().inset(8)
        }

        closeButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(8)
            make.trailing.equalToSuperview().inset(8)
            make.size.equalTo(CGSize(width: 30, height: 30))
        }
    }

    func configure(with activity: ActivityModel) {
        activityTitleLabel.text = activity.title
        activityDescriptionLabel.text = activity.description
        activityImageView.image = UIImage(data: activity.image)
    }
}
