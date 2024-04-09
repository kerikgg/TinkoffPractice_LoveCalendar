//
//  SignInViewController.swift
//  LoveCalendar
//
//  Created by kerik on 01.04.2024.
//

import UIKit
import SnapKit
import Combine

class SignInViewController: UIViewController, FlowController {
    var completionHandler: (() -> Void)?
    private let viewModel: SignInViewModel
    var cancellables = Set<AnyCancellable>()

    private lazy var signInLabel: UILabel = {
        let label = UILabel()
        label.text = "Вход"
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

    private lazy var errorsLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .red
        label.numberOfLines = 0
        return label
    }()

    private lazy var signInButton: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.layer.cornerRadius = 8
        button.titleLabel?.font = .systemFont(ofSize: 18)
        button.setTitle("Войти", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(named: "ButtonTextColor")

        let action = UIAction { [weak self] _ in
            guard let self else { return }
            self.viewModel.signInUser(email: emailTextField.text, password: passwordTextField.text)
        }
        button.addAction(action, for: .touchUpInside)

        return button
    }()

    init(viewModel: SignInViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        view.backgroundColor = .white
        setLayout()
        setBindings()
    }
}

extension SignInViewController {
    private func setBindings() {
        viewModel.$validationError
            .receive(on: DispatchQueue.main)
            .sink { [weak self] validationError in
                guard let self = self else { return }
                self.errorsLabel.text = validationError
            }
            .store(in: &cancellables)

        viewModel.$isSuccessfullyLoggedIn
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isSuccessfullyLoggedIn in
                if isSuccessfullyLoggedIn {
                    guard let self else { return }
                    self.completionHandler?()
                    print("работает, но дальше переход пока не сделал")
                }
            }
            .store(in: &cancellables)

        viewModel.$firebaseError
            .receive(on: DispatchQueue.main)
            .sink { [weak self] firebaseError in
                guard let self = self else { return }
                self.errorsLabel.text = firebaseError
            }
            .store(in: &cancellables)
    }
}

extension SignInViewController {
    private func setLayout() {
        let stackView = UIStackView(arrangedSubviews: [emailTextField, passwordTextField])
        stackView.axis = .vertical
        stackView.spacing = 20

        addSubviews(signInLabel, stackView, errorsLabel, signInButton)

        signInLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(view.frame.height * 0.2)
        }

        stackView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalTo(300)
            make.top.equalTo(signInLabel).offset(view.frame.height * 0.1)
        }

        errorsLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(stackView.snp_bottomMargin).offset(50)
            make.left.right.equalTo(stackView)
        }

        signInButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalTo(200)
            make.top.equalTo(errorsLabel).offset(view.frame.height * 0.1)
        }
    }
}

extension SignInViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case emailTextField:
            passwordTextField.becomeFirstResponder()
        case passwordTextField:
            view.endEditing(true)
        default:
            break
        }
        return true
    }
}
