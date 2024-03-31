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
        authController.completionHandler = { [weak self] state in
            guard let self else { return }
            switch state {
            case .signIn:
                self.runSignInFlow()
            case .signUp:
                self.runSignUpFlow()
            }
        }
        router.push(authController, animated: true)
    }

    private func runSignInFlow() {
        print("SignIn")
        // TODO: сделать вход
    }

    private func runSignUpFlow() {
        print("SignUp")
        let registrationFlowCoordinator = coordinatorFactory.makeRegistrationFlowCoordinator(
            router: router,
            coordinatorFactory: coordinatorFactory,
            moduleFactory: moduleFactory
        )
        registrationFlowCoordinator.start()
        addCoordinatorDependency(registrationFlowCoordinator)
        registrationFlowCoordinator.flowCompletionHandler = { [weak self] in
            guard let self else { return }
            self.router.popToRootController(animated: false)
            self.runSignInFlow()
            self.deleteCoordinatorDependency(registrationFlowCoordinator)
        }
    }
}