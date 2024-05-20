//
//  ProfileView.swift
//  LoveCalendar
//
//  Created by kerik on 18.05.2024.
//

import UIKit

protocol ProfileViewDelegate: AnyObject {
    func didTapChangeAvatar()
}

final class ProfileView: UIView {
    lazy var userImage: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.labelText.cgColor
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill

        return imageView
    }()

    private lazy var changeAvatarButton: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.setTitle("Сменить аватар", for: .normal)
        let action = UIAction { [weak self] _ in
            guard let self else { return }
            self.delegate?.didTapChangeAvatar()
        }
        button.addAction(action, for: .touchUpInside)

        return button
    }()

    private lazy var userNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = .black

        return label
    }()

    private lazy var userEmailLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = .black

        return label
    }()

    private lazy var randomActivityButton: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.layer.cornerRadius = 20
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        button.setTitle(Strings.Buttons.ideaForMeeting, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor.buttonText

        let action = UIAction { [weak self] _ in
            guard let self else { return }
        }
        button.addAction(action, for: .touchUpInside)

        return button
    }()

    weak var delegate: ProfileViewDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews(userImage, changeAvatarButton, userNameLabel, userEmailLabel, randomActivityButton)
        makeConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        userImage.layer.cornerRadius = userImage.frame.width / 2
    }
}

extension ProfileView {
    private func makeConstraints() {
        userImage.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 120, height: 120))
            make.top.equalToSuperview().inset(120)
        }

        changeAvatarButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(userImage.snp_bottomMargin).offset(10)
        }

        userNameLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(changeAvatarButton).offset(50)
        }

        userEmailLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(userNameLabel).offset(25)
        }

        randomActivityButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 220, height: 45))
            make.bottom.equalToSuperview().inset(150)
        }
    }
}

extension ProfileView {
    func configureProfile(with user: UserModel) {
        userNameLabel.text = user.name
        userEmailLabel.text = user.email
        if let imageData = user.avatarData {
            userImage.image = UIImage(data: imageData)
        } else {
            userImage.image = UIImage.profileIcon
        }
    }
}
