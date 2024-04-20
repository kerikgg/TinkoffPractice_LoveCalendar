//
//  RegistrationView.swift
//  LoveCalendar
//
//  Created by kerik on 14.04.2024.
//

import UIKit

protocol RegistrationViewDelegate: AnyObject {
    func didPressSignUpButton(_ email: String?, _ password: String?, _ passwordConfirmation: String?)
}

final class RegistrationView: UIView {
    weak var delegate: RegistrationViewDelegate?

    private lazy var regLabel: UILabel = {
        let label = UILabel()
        label.text = Strings.Labels.signUpLabel
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = UIColor.labelText

        return label
    }()

    private lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = Strings.TextFields.emailPlaceholder
        textField.borderStyle = .roundedRect
        textField.keyboardType = .emailAddress
        textField.returnKeyType = .next
        textField.delegate = self
        textField.textColor = UIColor.labelText
        textField.font = .systemFont(ofSize: 18)

        return textField
    }()

    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = Strings.TextFields.passwordPlaceholder
        textField.borderStyle = .roundedRect
        textField.isSecureTextEntry = true
        textField.returnKeyType = .next
        textField.delegate = self
        textField.textColor = UIColor.labelText
        textField.font = .systemFont(ofSize: 18)

        return textField
    }()

    private lazy var passwordConfirmationTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = Strings.TextFields.passwordConfirmationPlaceholder
        textField.borderStyle = .roundedRect
        textField.isSecureTextEntry = true
        textField.returnKeyType = .done
        textField.delegate = self
        textField.textColor = UIColor.labelText
        textField.font = .systemFont(ofSize: 18)

        return textField
    }()

    private lazy var errorsLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .red
        label.numberOfLines = 0

        return label
    }()

    private lazy var regButton: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.layer.cornerRadius = 20
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        button.setTitle(Strings.Buttons.signUp, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor.buttonText

        let action = UIAction { [weak self] _ in
            guard let self else { return }
            self.delegate?.didPressSignUpButton(
                emailTextField.text, passwordTextField.text, passwordConfirmationTextField.text
            )
        }
        button.addAction(action, for: .touchUpInside)

        return button
    }()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            emailTextField,
            passwordTextField,
            passwordConfirmationTextField
        ])
        stackView.axis = .vertical
        stackView.spacing = 20

        return stackView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews(regLabel, stackView, errorsLabel, regButton)
        makeConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension RegistrationView {
    func setErrors(_ errors: String) {
        errorsLabel.text = errors
    }
}

extension RegistrationView {
    private func makeConstraints() {
        regLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(150)
        }

        stackView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalTo(300)
            make.top.equalTo(regLabel).offset(100)
        }

        errorsLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(stackView.snp_bottomMargin).offset(50)
            make.leading.trailing.equalTo(stackView)
        }

        regButton.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 250, height: 45))
            make.centerX.equalToSuperview()
            make.top.equalTo(errorsLabel).offset(100)
        }
    }
}

extension RegistrationView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case emailTextField:
            passwordTextField.becomeFirstResponder()
        case passwordTextField:
            passwordConfirmationTextField.becomeFirstResponder()
        case passwordConfirmationTextField:
            self.endEditing(true)
        default:
            break
        }
        return true
    }
}
