//
//  ProfileViewController.swift
//  LoveCalendar
//
//  Created by kerik on 21.04.2024.
//

import UIKit
import SnapKit

class ProfileViewController: UIViewController, FlowController {
    var completionHandler: (() -> Void)?

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
            self?.completionHandler?()
        }

        let button = UIBarButtonItem(image: SystemImages.logOut, primaryAction: action)
        button.tintColor = .buttonText

        return button
    }
}
