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
        router.setViewController(authController)
    }

    private func runSignInFlow() {
        print("SignIn")
        let signInFlowCoordinator = coordinatorFactory.makeSignInFlowCoordinator(router: router)
        signInFlowCoordinator.start()
        addCoordinatorDependency(signInFlowCoordinator)
        signInFlowCoordinator.flowCompletionHandler = { [weak self, weak signInFlowCoordinator] flowCompletionState in
            guard let self else { return }
            switch flowCompletionState {
            case .back:
                self.deleteCoordinatorDependency(signInFlowCoordinator)
            case .next:
                self.flowCompletionHandler?(nil)
                self.deleteCoordinatorDependency(signInFlowCoordinator)
            case .none:
                break
            }
            self.deleteCoordinatorDependency(signInFlowCoordinator)
        }
    }

    private func runSignUpFlow() {
        print("SignUp")
        let registrationFlowCoordinator = coordinatorFactory.makeRegistrationFlowCoordinator(router: router)
        registrationFlowCoordinator.start()
        addCoordinatorDependency(registrationFlowCoordinator)
        // swiftlint:disable:next line_length
        registrationFlowCoordinator.flowCompletionHandler = { [weak self, weak registrationFlowCoordinator] flowCompletionState in
            guard let self else { return }

            switch flowCompletionState {
            case .back:
                self.deleteCoordinatorDependency(registrationFlowCoordinator)
            case .next:
                self.router.popToRootController(animated: false)
                self.runSignInFlow()
                self.deleteCoordinatorDependency(registrationFlowCoordinator)
            case .none:
                break
            }
        }
    }
}
