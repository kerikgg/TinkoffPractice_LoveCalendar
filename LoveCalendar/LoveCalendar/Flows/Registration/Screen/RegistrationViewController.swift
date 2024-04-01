//
//  RegistrationViewController.swift
//  LoveCalendar
//
//  Created by kerik on 30.03.2024.
//

import UIKit
import Combine

class RegistrationViewController: UIViewController, FlowController {
    private lazy var regLabel: UILabel = {
        let label = UILabel()
        label.text = "Регистрация"
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = UIColor(named: "LabelTextColor")
        return label
    }()

    private lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Почта"
        textField.borderStyle = .roundedRect
        textField.keyboardType = .emailAddress
        textField.returnKeyType = .next
        textField.delegate = self
        textField.textColor = UIColor(named: "LabelTextColor")
        textField.font = .systemFont(ofSize: 18)
        return textField
    }()

    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Пароль"
        textField.borderStyle = .roundedRect
        textField.isSecureTextEntry = true
        textField.returnKeyType = .next
        textField.delegate = self
        textField.textColor = UIColor(named: "LabelTextColor")
        textField.font = .systemFont(ofSize: 18)
        return textField
    }()

    private lazy var passwordConfirmationTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Подтвердите пароль"
        textField.borderStyle = .roundedRect
        textField.isSecureTextEntry = true
        textField.returnKeyType = .done
        textField.delegate = self
        textField.textColor = UIColor(named: "LabelTextColor")
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
        button.layer.cornerRadius = 8
        button.titleLabel?.font = .systemFont(ofSize: 18)
        button.setTitle("Зарегестрироваться", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(named: "ButtonTextColor")

        let action = UIAction { [weak self] _ in
            guard let self else { return }
            self.viewModel.signUpUser(emailTextField.text, passwordTextField.text, passwordConfirmationTextField.text)
        }
        button.addAction(action, for: .touchUpInside)

        return button
    }()

    var completionHandler: (() -> Void)?
    private let viewModel: RegistrationViewModel
    var cancellables = Set<AnyCancellable>()

    init(viewModel: RegistrationViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setLayout()
        setBindings()
    }
}

extension RegistrationViewController {
    private func setLayout() {
        let stackView = UIStackView(arrangedSubviews: [
            emailTextField,
            passwordTextField,
            passwordConfirmationTextField
        ])
        stackView.axis = .vertical
        stackView.spacing = 20

        addSubviews(regLabel, stackView, errorsLabel, regButton)

        regLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(view.frame.height * 0.2)
        }

        stackView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalTo(300)
            make.top.equalTo(regLabel).offset(view.frame.height * 0.1)
        }

        errorsLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(stackView.snp_bottomMargin).offset(50)
            make.left.right.equalTo(stackView)
        }

        regButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalTo(200)
            make.top.equalTo(errorsLabel).offset(view.frame.height * 0.1)
        }
    }
}

extension RegistrationViewController {
    private func setBindings() {
        viewModel.$isSuccessfulRegistered
            .sink { [weak self] isSuccessfulRegistered in
                guard let self = self else { return }
                if isSuccessfulRegistered {
                    self.completionHandler?()
                }
            }
            .store(in: &cancellables)

        viewModel.$errorStringFormatted
            .receive(on: DispatchQueue.main)
            .sink { [weak self] errorStringFormatted in
                guard let self = self else { return }
                self.errorsLabel.text = errorStringFormatted
            }
            .store(in: &cancellables)
    }
}

extension RegistrationViewController {
    func addSubviews(_ subviews: UIView...) {
        subviews.forEach { view.addSubview($0) }
    }
}

extension RegistrationViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case emailTextField:
            passwordTextField.becomeFirstResponder()
        case passwordTextField:
            passwordConfirmationTextField.becomeFirstResponder()
        case passwordConfirmationTextField:
            view.endEditing(true)
        default:
            break
        }
        return true
    }
}
