//
//  AuthView.swift
//  LoveCalendar
//
//  Created by kerik on 12.04.2024.
//

import UIKit

protocol AuthViewDelegate: AnyObject {
    func didPressSignIn()
    func didPressSignUp()
}

class AuthView: UIView {
    weak var delegate: AuthViewDelegate?

    private let backgroundView = BackgroundView(frame: .zero)

//    private lazy var welcomeLabel: UILabel = {
//        let label = UILabel()
//        label.text = "Добро пожаловать!"
//        label.font = .systemFont(ofSize: 20, weight: .bold)
//        label.textColor = UIColor(named: "LabelTextColor")
//        return label
//    }()

    private lazy var logoImage: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "logo"))
        imageView.layer.cornerRadius = 30
        imageView.layer.borderWidth = 5
        imageView.layer.borderColor = UIColor(named: "ButtonTextColor")?.cgColor
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    private lazy var signInButton: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.layer.cornerRadius = 20
        button.setTitle("Войти", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        button.backgroundColor = UIColor(named: "ButtonTextColor")

        let action = UIAction { [weak self] _ in
            // self?.completionHandler?(.signIn)
            self?.delegate?.didPressSignIn()
        }
        button.addAction(action, for: .touchDown)

        return button
    }()

    private lazy var signUpButton: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.layer.cornerRadius = 20
        button.setTitle("Зарегистрироваться", for: .normal)
        button.setTitleColor(UIColor(named: "LabelTextColor"), for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        button.backgroundColor = .systemGray3

        let action = UIAction { [weak self] _ in
            // self?.completionHandler?(.signUp)
            self?.delegate?.didPressSignUp()
        }
        button.addAction(action, for: .touchDown)

        return button
    }()

    private lazy var stackView: UIStackView = createStackView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews(backgroundView, logoImage, stackView)
        makeConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension AuthView {
    private func createStackView() -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: [signInButton, signUpButton])
        stackView.axis = .vertical
        stackView.spacing = 20

        return stackView
    }

    private func makeConstraints() {
        backgroundView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }

        logoImage.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalTo(230)
            make.height.equalTo(170)
            make.top.equalToSuperview().offset(220)
        }

        signInButton.snp.makeConstraints { make in
            make.height.equalTo(45)
        }

        signUpButton.snp.makeConstraints { make in
            make.height.equalTo(45)
        }

        stackView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(logoImage.snp_bottomMargin).offset(80)
            make.left.equalToSuperview().offset(30)
            make.right.equalToSuperview().offset(-30)
        }
    }
}
