//
//  RegistrationFlowCoordinator.swift
//  LoveCalendar
//
//  Created by kerik on 30.03.2024.
//

import Foundation

class RegistrationFlowCoordinator: Coordinator {
    private var router: RouterProtocol

    init(router: RouterProtocol) {
        self.router = router
    }

    override func start() {
        showRegistration()
    }

    private func showRegistration() {
        let registrationViewController = moduleFactory.makeRegistrationModule(viewModel: RegistrationViewModel())
        registrationViewController.completionHandler = { [weak self] in
            guard let self else { return }
            self.flowCompletionHandler?()
        }
        router.push(registrationViewController, animated: true)
    }
}
