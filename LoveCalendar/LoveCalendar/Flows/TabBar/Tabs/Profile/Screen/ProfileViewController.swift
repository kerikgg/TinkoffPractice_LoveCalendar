//
//  ProfileViewController.swift
//  LoveCalendar
//
//  Created by kerik on 21.04.2024.
//

import UIKit
import SnapKit

enum ProfileStates {
    case logOut, settings
}

class ProfileViewController: UIViewController, FlowControllerWithValue {
    var completionHandler: ((ProfileStates) -> Void)?

    private let viewModel: ProfileViewModel

    init(viewModel: ProfileViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = Strings.Titles.profile

        let leftBarButtonItem = customLeftBarButtonItem()
        navigationItem.leftBarButtonItem = leftBarButtonItem
    }
}

extension ProfileViewController {
    private func customLeftBarButtonItem() -> UIBarButtonItem {
        let action = UIAction { [weak self] _ in
            self?.viewModel.logOut()
            self?.completionHandler?(.logOut)
        }

        let button = UIBarButtonItem(image: SystemImages.logOut, primaryAction: action)
        button.tintColor = .buttonText

        return button
    }
}
