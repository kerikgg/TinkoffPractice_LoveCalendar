//
//  EditProfileView.swift
//  LoveCalendar
//
//  Created by kerik on 24.05.2024.
//

import UIKit

protocol EditProfileViewDelegate: AnyObject {
    func didTapChangeAvatar()
    func didTapSave()
}

final class EditProfileView: UIView {
    private lazy var userImage: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.labelText.cgColor
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill

        return imageView
    }()

    private lazy var changeAvatarButton: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.setTitle(Strings.Buttons.changeAvatar, for: .normal)
        
        let action = UIAction { [weak self] _ in
            guard let self else { return }
            self.delegate?.didTapChangeAvatar()
        }
        button.addAction(action, for: .touchUpInside)

        return button
    }()

    private lazy var nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = Strings.TextFields.namePlaceholder
        textField.borderStyle = .roundedRect
        textField.returnKeyType = .next
        textField.delegate = self
        textField.textColor = UIColor.labelText
        textField.font = .systemFont(ofSize: 18)

        return textField
    }()

    private lazy var saveButton: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.layer.cornerRadius = 20
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        button.setTitle(Strings.Buttons.save, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor.buttonText

        let action = UIAction { [weak self] _ in
            guard let self else { return }
            self.delegate?.didTapSave()
        }
        button.addAction(action, for: .touchUpInside)

        return button
    }()

    weak var delegate: EditProfileViewDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .background
        addSubviews(userImage, changeAvatarButton, nameTextField, saveButton)
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

extension EditProfileView {
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

        nameTextField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalTo(300)
            make.top.equalTo(changeAvatarButton).offset(50)
        }

        saveButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 250, height: 45))
            make.top.equalTo(nameTextField).offset(100)
        }
    }
}

extension EditProfileView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        endEditing(true)
        return true
    }
}

extension EditProfileView {
    func setNameTextField(_ name: String) {
        self.nameTextField.text = name
    }

    func setUserImage(_ image: UIImage) {
        self.userImage.image = image
    }

    func getNameTextField() -> String {
        self.nameTextField.text ?? ""
    }

    func configureProfile(with user: UserModel) {
        nameTextField.text = user.name
        if let imageData = user.avatarData {
            userImage.image = UIImage(data: imageData)
        } else {
            userImage.image = UIImage.profileIcon
        }
    }
}
