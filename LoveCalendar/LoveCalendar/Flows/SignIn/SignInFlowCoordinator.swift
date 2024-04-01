//
//  SignInFlowCoordinator.swift
//  LoveCalendar
//
//  Created by kerik on 01.04.2024.
//

import Foundation

class SignInFlowCoordinator: Coordinator {
    private var router: RouterProtocol
    private var coordinatorFactory: CoordinatorFactoryProtocol
    private var moduleFactory: ModuleFactoryProtocol

    init(router: RouterProtocol, coordinatorFactory: CoordinatorFactoryProtocol, moduleFactory: ModuleFactoryProtocol) {
        self.router = router
        self.coordinatorFactory = coordinatorFactory
        self.moduleFactory = moduleFactory
    }

    override func start() {
        showSignIn()
    }

    private func showSignIn() {
        let signInViewController = moduleFactory.makeSignInModule(viewModel: SignInViewModel())
        signInViewController.completionHandler = { [weak self] in
            guard let self else { return }
            self.flowCompletionHandler?()
        }
        router.push(signInViewController, animated: true)
    }
}
