//
//  SignInFlowCoordinator.swift
//  LoveCalendar
//
//  Created by kerik on 01.04.2024.
//

import Foundation

class SignInFlowCoordinator: Coordinator {
    private var router: RouterProtocol

    init(router: RouterProtocol) {
        self.router = router
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
