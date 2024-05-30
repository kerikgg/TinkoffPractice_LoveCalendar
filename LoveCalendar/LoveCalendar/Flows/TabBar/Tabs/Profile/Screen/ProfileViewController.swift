//
//  ProfileViewController.swift
//  LoveCalendar
//
//  Created by kerik on 21.04.2024.
//

import UIKit
import SnapKit
import Combine

enum ProfileStates {
    case logOut, settings
}

class ProfileViewController: UIViewController, FlowControllerWithValue {
    var completionHandler: ((ProfileStates) -> Void)?
    private let profileView = ProfileView(frame: .zero)
    private let viewModel: ProfileViewModel
    private let alertFactory = AlertFactory()
    var cancellables = Set<AnyCancellable>()

    init(viewModel: ProfileViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        viewModel.getUserData()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = profileView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setBindings()
        setupNavigationBar()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.getUserData()
    }
}

extension ProfileViewController {
    private func customLeftBarButtonItem() -> UIBarButtonItem {
        let action = UIAction { [weak self] _ in
            guard let self else { return }
            self.showLogOutAlert()
        }

        let button = UIBarButtonItem(image: SystemImages.logOut, primaryAction: action)
        button.tintColor = .buttonText

        return button
    }

    private func customRightBarButtonItem() -> UIBarButtonItem {
        let action = UIAction { [weak self] _ in
            guard let self else { return }
            self.completionHandler?(.settings)
        }

        let button = UIBarButtonItem(image: SystemImages.gearShape, primaryAction: action)
        button.tintColor = .buttonText

        return button
    }

    private func setupNavigationBar() {
        navigationItem.title = Strings.Titles.profile

        let leftBarButtonItem = customLeftBarButtonItem()
        let rightBarButtonItem = customRightBarButtonItem()
        navigationItem.leftBarButtonItem = leftBarButtonItem
        navigationItem.rightBarButtonItem = rightBarButtonItem
    }
}

extension ProfileViewController {
    private func showLogOutAlert() {
        let alert = alertFactory.makeLogOutAlert { [weak self] _ in
            guard let self else { return }
            self.viewModel.logOut()
            self.completionHandler?(.logOut)
        }
        present(alert, animated: true)
    }
}

extension ProfileViewController {
    private func setBindings() {
        viewModel.$userModel
            .receive(on: DispatchQueue.main)
            .sink { [weak self] user in
                guard let self else { return }
                self.profileView.configureProfile(with: user)
            }
            .store(in: &cancellables)
    }
}
