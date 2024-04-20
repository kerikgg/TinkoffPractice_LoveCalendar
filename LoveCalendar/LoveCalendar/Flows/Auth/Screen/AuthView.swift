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

final class AuthView: UIView {
    weak var delegate: AuthViewDelegate?
    private let backgroundView = BackgroundView(frame: .zero)

    private lazy var logoImage: UIImageView = {
        let imageView = UIImageView(image: UIImage.logo)
        imageView.layer.cornerRadius = 30
        imageView.layer.borderWidth = 5
        imageView.layer.borderColor = UIColor.buttonText.cgColor
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill

        return imageView
    }()

    private lazy var signInButton: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.layer.cornerRadius = 20
        button.setTitle(Strings.Buttons.signIn, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        button.backgroundColor = UIColor.buttonText

        let action = UIAction { [weak self] _ in
            self?.delegate?.didPressSignIn()
        }
        button.addAction(action, for: .touchDown)

        return button
    }()

    private lazy var signUpButton: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.layer.cornerRadius = 20
        button.setTitle(Strings.Buttons.signUp, for: .normal)
        button.setTitleColor(UIColor.labelText, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        button.backgroundColor = .systemGray3

        let action = UIAction { [weak self] _ in
            self?.delegate?.didPressSignUp()
        }
        button.addAction(action, for: .touchDown)

        return button
    }()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [signInButton, signUpButton])
        stackView.axis = .vertical
        stackView.spacing = 20

        return stackView
    }()

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
    private func makeConstraints() {
        backgroundView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        logoImage.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 230, height: 170))
            make.centerX.equalToSuperview()
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
            make.leading.equalToSuperview().inset(30)
            make.trailing.equalToSuperview().inset(30)
        }
    }
}
