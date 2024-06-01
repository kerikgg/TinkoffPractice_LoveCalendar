//
//  AddCounterView.swift
//  LoveCalendar
//
//  Created by kerik on 31.05.2024.
//

import UIKit

protocol AddCounterViewDelegate: AnyObject {
    func didTapSave(partnerName: String?, date: Date)
    func didTapChoosePhoto()
}

final class AddCounterView: UIView {
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

    private lazy var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.calendar = .autoupdatingCurrent
        datePicker.locale = .autoupdatingCurrent
        datePicker.maximumDate = Date()

        let action = UIAction { [weak self] _ in
            self?.pickedDate = datePicker.date
        }
        datePicker.addAction(action, for: .valueChanged)

        return datePicker
    }()

    private lazy var partnerNameTextField: UITextField = {
        let textField = UITextField()
        textField.textColor = .black
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .words
        textField.placeholder = "Имя партнера"
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
            self.delegate?.didTapSave(partnerName: partnerNameTextField.text, date: pickedDate)
        }
        button.addAction(action, for: .touchUpInside)

        return button
    }()

    weak var delegate: AddCounterViewDelegate?
    private var pickedDate = Date()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .background
        addSubviews(imageView, datePicker, partnerNameTextField, saveButton)
        makeConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension AddCounterView {
    @objc private func handleTap() {
        self.delegate?.didTapChoosePhoto()
    }
}

extension AddCounterView {
    private func makeConstraints() {
        datePicker.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(150)
        }

        imageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 250, height: 250))
            make.top.equalTo(datePicker).offset(50)
        }

        partnerNameTextField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalTo(250)
            make.top.equalTo(imageView.snp_bottomMargin).offset(50)
        }

        saveButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 220, height: 45))
            make.top.equalTo(partnerNameTextField.snp_bottomMargin).offset(50)
        }
    }
}

extension AddCounterView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        endEditing(true)
        return true
    }
}

extension AddCounterView {
    func configureImage(_ image: UIImage) {
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = image
    }
}
