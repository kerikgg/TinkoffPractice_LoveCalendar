//
//  AddWishView.swift
//  LoveCalendar
//
//  Created by kerik on 25.05.2024.
//

import UIKit

protocol AddWishViewDelegate: AnyObject {
    func didTapSave(title: String, url: String?)
}

final class AddWishView: UIView {
//    private lazy var viewLabel: UILabel = {
//        let label = UILabel()
//        label.text = Strings.Labels.addWishLabel
//        label.font = .systemFont(ofSize: 17, weight: .semibold)
//        label.textColor = .black
//
//        return label
//    }()

    private lazy var titleTextField: UITextField = {
        let textField = UITextField()
        textField.textColor = .black
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        textField.placeholder = Strings.TextFields.wishTitlePlaceholder
        textField.delegate = self
        textField.borderStyle = .roundedRect
        textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)

        return textField
    }()

    private lazy var urlTextField: UITextField = {
        let textField = UITextField()
        textField.textColor = .black
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        textField.placeholder = Strings.TextFields.wishUrlPlaceholder
        textField.delegate = self
        textField.borderStyle = .roundedRect

        return textField
    }()

    private lazy var saveButton: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.layer.cornerRadius = 20
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        button.setTitle(Strings.Buttons.save, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor.buttonText
        button.isEnabled = false
        button.alpha = 0.5

        let action = UIAction { [weak self] _ in
            guard let self else { return }
            self.handleSaveButtonTap()
        }
        button.addAction(action, for: .touchUpInside)

        return button
    }()

    weak var delegate: AddWishViewDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .background
        addSubviews(titleTextField, urlTextField, saveButton)
        makeConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension AddWishView {
    private func makeConstraints() {
        titleTextField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalTo(300)
            make.top.equalToSuperview().inset(150)
        }

        urlTextField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalTo(300)
            make.top.equalTo(titleTextField).offset(50)
        }

        saveButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 220, height: 45))
            make.top.equalTo(urlTextField).offset(100)
        }
    }
}

extension AddWishView {
    private func handleSaveButtonTap() {
        guard let title = titleTextField.text, !title.isEmpty else { return }
        delegate?.didTapSave(title: title, url: urlTextField.text)
    }

    @objc private func textFieldDidChange(_ textField: UITextField) {
        let isTitleValid = !(titleTextField.text?.isEmpty ?? true)
        saveButton.isEnabled = isTitleValid
        saveButton.alpha = isTitleValid ? 1.0 : 0.5
    }
}

extension AddWishView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        endEditing(true)
        return true
    }
}
