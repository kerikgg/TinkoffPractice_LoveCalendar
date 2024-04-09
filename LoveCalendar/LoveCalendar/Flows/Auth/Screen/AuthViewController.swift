//
//  ViewController.swift
//  LoveCalendar
//
//  Created by kerik on 26.03.2024.
//

import UIKit
import SnapKit

enum AuthStates {
    case signIn
    case signUp
}

class AuthViewController: UIViewController, FlowControllerWithValue {
    private lazy var welcomeLabel: UILabel = {
        let label = UILabel()
        label.text = "Добро пожаловать!"
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = UIColor(named: "LabelTextColor")
        return label
    }()

    private lazy var logoImage: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "logo"))
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    private lazy var signInButton: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.layer.cornerRadius = 8
        button.titleLabel?.font = .systemFont(ofSize: 18)
        button.setTitle("Войти", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(named: "ButtonTextColor")

        let action = UIAction { [weak self] _ in
            self?.completionHandler?(.signIn)
        }
        button.addAction(action, for: .touchDown)

        return button
    }()

    private lazy var signUpButton: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.layer.cornerRadius = 8
        button.titleLabel?.font = .systemFont(ofSize: 18)
        button.setTitle("Зарегистрироваться", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(named: "ButtonTextColor")

        let action = UIAction { [weak self] _ in
            self?.completionHandler?(.signUp)
        }
        button.addAction(action, for: .touchDown)
        
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setLayout()
    }

    var completionHandler: ((AuthStates) -> Void)?
}

extension AuthViewController {
    private func setLayout() {
        let stackView = UIStackView(arrangedSubviews: [signInButton, signUpButton])
        stackView.axis = .vertical
        stackView.spacing = 20

        addSubviews(welcomeLabel, logoImage, stackView)

        welcomeLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(view.frame.height * 0.2)
        }

        logoImage.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalTo(250)
            make.height.equalTo(170)
            make.top.equalTo(welcomeLabel).offset(view.frame.height * 0.09)
        }

        stackView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalTo(200)
            make.top.equalTo(logoImage).offset(200)
        }
    }
}
