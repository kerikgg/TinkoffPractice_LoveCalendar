//
//  AddPhotoVIew.swift
//  LoveCalendar
//
//  Created by kerik on 30.05.2024.
//

import UIKit

protocol AddPhotoViewDelegate: AnyObject {
    func didTapSave(title: String)
    func didTapChoosePhoto()
}

final class AddPhotoView: UIView {
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.borderWidth = 1
        imageView.layer.cornerRadius = 10
        imageView.layer.borderColor = UIColor.labelText.cgColor
        imageView.contentMode = .center
        imageView.tintColor = .labelText

        let config = UIImage.SymbolConfiguration(pointSize: 50, weight: .regular, scale: .medium)
        let image = UIImage(systemName: SystemImages.photo, withConfiguration: config)
        imageView.image = image

        imageView.isUserInteractionEnabled = true

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        imageView.addGestureRecognizer(tapGesture)

        return imageView
    }()

    private lazy var titleTextField: UITextField = {
        let textField = UITextField()
        textField.textColor = .labelText
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        textField.placeholder = Strings.TextFields.photoTitlePlaceholder
        textField.delegate = self
        textField.borderStyle = .roundedRect

        return textField
    }()

    private lazy var saveButton: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.layer.cornerRadius = 20
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        button.setTitle(Strings.Buttons.add, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor.buttonText

        let action = UIAction { [weak self] _ in
            guard let self else { return }
            guard let title = titleTextField.text else { return}
            self.delegate?.didTapSave(title: title)
        }
        button.addAction(action, for: .touchUpInside)

        return button
    }()

    weak var delegate: AddPhotoViewDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .background
        addSubviews(imageView, titleTextField, saveButton)
        makeConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension AddPhotoView {
    @objc private func handleTap() {
        self.delegate?.didTapChoosePhoto()
    }
}

extension AddPhotoView {
    private func makeConstraints() {
        imageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 250, height: 250))
            make.top.equalToSuperview().inset(150)
        }

        titleTextField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalTo(250)
            make.top.equalTo(imageView.snp_bottomMargin).offset(50)
        }

        saveButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 220, height: 45))
            make.top.equalTo(titleTextField.snp_bottomMargin).offset(50)
        }
    }
}

extension AddPhotoView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        endEditing(true)
        return true
    }
}

extension AddPhotoView {
    func configureImage(_ image: UIImage) {
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = image
    }
}
