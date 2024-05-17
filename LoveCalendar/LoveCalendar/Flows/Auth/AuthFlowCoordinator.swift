//
//  AuthFlowCoordinator.swift
//  LoveCalendar
//
//  Created by kerik on 29.03.2024.
//

import Foundation

class AuthFlowCoordinator: Coordinator {
    private var router: RouterProtocol

    init(router: RouterProtocol) {
        self.router = router
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
        let signInFlowCoordinator = coordinatorFactory.makeSignInFlowCoordinator(
            router: router
        )
        addCoordinatorDependency(signInFlowCoordinator)
        signInFlowCoordinator.flowCompletionHandler = { [weak self] in
            guard let self else { return }
            self.deleteCoordinatorDependency(signInFlowCoordinator)
            self.flowCompletionHandler?()
        }
        signInFlowCoordinator.start()
    }

    private func runSignUpFlow() {
        print("SignUp")
        let registrationFlowCoordinator = coordinatorFactory.makeRegistrationFlowCoordinator(
            router: router
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
