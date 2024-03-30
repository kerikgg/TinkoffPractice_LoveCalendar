//
//  RegistrationFlowCoordinator.swift
//  LoveCalendar
//
//  Created by kerik on 30.03.2024.
//

import Foundation

class RegistrationFlowCoordinator: Coordinator {
    private var router: RouterProtocol
    private var coordinatorFactory: CoordinatorFactoryProtocol
    private var moduleFactory: ModuleFactoryProtocol

    init(router: RouterProtocol, coordinatorFactory: CoordinatorFactoryProtocol, moduleFactory: ModuleFactoryProtocol) {
        self.router = router
        self.coordinatorFactory = coordinatorFactory
        self.moduleFactory = moduleFactory
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
