//
//  ProfileView.swift
//  LoveCalendar
//
//  Created by kerik on 18.05.2024.
//

import UIKit

protocol ProfileViewDelegate: AnyObject {
    func didTapRandomActivityButton()
    func displayActivity(_ activity: ActivityModel)
}

final class ProfileView: UIView {
    weak var delegate: ProfileViewDelegate?
    
    lazy var userImage: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.labelText.cgColor
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        
        return imageView
    }()
    
    private lazy var userNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = .labelText
        
        return label
    }()
    
    private lazy var userEmailLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = .labelText

        return label
    }()
    
    private lazy var activityView: ActivityView = {
        let view = ActivityView()
        view.isHidden = true
        view.delegate = self
        
        return view
    }()
    
    private lazy var randomActivityButton: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.layer.cornerRadius = 20
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        button.setTitle(Strings.Buttons.ideaForMeeting, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor.buttonText
        
        let action = UIAction { [weak self] _ in
            guard let self else { return }
            self.delegate?.didTapRandomActivityButton()
        }
        button.addAction(action, for: .touchUpInside)
        
        return button
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .background
        addSubviews(userImage, userNameLabel, userEmailLabel, randomActivityButton, activityView, activityIndicator)
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        userImage.layer.cornerRadius = userImage.frame.width / 2
    }
    
    private func hideActivityView() {
        activityView.isHidden = true
        randomActivityButton.isHidden = false
    }
}

extension ProfileView {
    private func makeConstraints() {
        userImage.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 120, height: 120))
            make.top.equalToSuperview().inset(120)
        }
        
        userNameLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(userImage.snp_bottomMargin).offset(50)
        }
        
        userEmailLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(userNameLabel).offset(25)
        }
        
        randomActivityButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 220, height: 45))
            make.bottom.equalToSuperview().inset(150)
        }
        
        activityView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().inset(16)
            make.top.equalTo(userEmailLabel.snp.bottom).offset(30)
        }
        
        activityIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}

extension ProfileView {
    func configureProfile(with user: UserModel) {
        userNameLabel.text = user.name
        userEmailLabel.text = user.email
        if let imageData = user.avatarData {
            userImage.image = UIImage(data: imageData)
        } else {
            userImage.image = UIImage.profileIcon
        }
    }
    
    func displayActivity(_ activity: ActivityModel) {
        activityView.configure(with: activity)
        activityView.isHidden = false
        randomActivityButton.isHidden = true
    }
    
    func setLoading(_ isLoading: Bool) {
        if isLoading {
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
        }
    }
}

extension ProfileView: ActivityViewDelegate {
    func didTapCloseButton() {
        self.hideActivityView()
    }
}
