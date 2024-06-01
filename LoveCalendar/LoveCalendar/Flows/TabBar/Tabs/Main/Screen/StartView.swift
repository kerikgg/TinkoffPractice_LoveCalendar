//
//  StratView.swift
//  LoveCalendar
//
//  Created by kerik on 31.05.2024.
//

import UIKit

protocol StartViewDelegate: AnyObject {
    func didTapStartButton()
}

final class StartView: UIView {
    weak var delegate: StartViewDelegate?

    private lazy var welcomeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textColor = .labelText
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = "Не помните сколько вы вместе?"
        label.isHidden = false

        return label
    }()

    private lazy var startLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textColor = .labelText
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = "Начните счетчик ваших отношений прямо сейчас!"
        label.isHidden = false

        return label
    }()

    private lazy var startButton: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.layer.cornerRadius = 20
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        button.setTitle("Начать", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor.buttonText
        button.isHidden = false

        let action = UIAction { [weak self] _ in
            guard let self else { return }
            delegate?.didTapStartButton()
        }
        button.addAction(action, for: .touchUpInside)

        return button
    }()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [welcomeLabel, startLabel])
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.alignment = .fill
        stackView.distribution = .fillProportionally

        return stackView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews(startButton, stackView)
        makeConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension StartView {
    private func makeConstraints() {
        stackView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(20)
        }

        startButton.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp_bottomMargin).offset(20)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 220, height: 45))
        }
    }
}
