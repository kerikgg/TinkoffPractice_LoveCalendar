//
//  AuthFlowCoordinator.swift
//  LoveCalendar
//
//  Created by kerik on 29.03.2024.
//

import Foundation

class AuthFlowCoordinator: Coordinator {
    private var router: RouterProtocol
    private var coordinatorFactory: CoordinatorFactoryProtocol
    private var moduleFactory: ModuleFactoryProtocol

    init(router: RouterProtocol, coordinatorFactory: CoordinatorFactoryProtocol, moduleFactory: ModuleFactoryProtocol) {
        self.router = router
        self.coordinatorFactory = coordinatorFactory
        self.moduleFactory = moduleFactory
    }

    override func start() {
        showAuth()
    }

    private func showAuth() {
        let authController = moduleFactory.makeAuthModule()
        router.push(authController, animated: true)
    }

    private func runSignInFlow() {
        print("SignIn")
        // TODO: сделать вход
    }

    private func runSignUpFlow() {
        print("SignUp")
        // TODO: сделать регистрацию
    }
}
