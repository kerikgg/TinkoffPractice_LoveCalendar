//
//  ProfileCoordinator.swift
//  LoveCalendar
//
//  Created by kerik on 21.04.2024.
//

import Foundation

class ProfileCoordinator: Coordinator {
    private var router: RouterProtocol

    init(router: RouterProtocol) {
        self.router = router
    }

    override func start() {
        showProfile()
    }

    private func showProfile() {
        let profileViewController = moduleFactory.makeProfileModule(viewModel: ProfileViewModel())
        profileViewController.completionHandler = { [weak self] in
            self?.flowCompletionHandler?()
        }
        router.setViewController(profileViewController)
    }
}
