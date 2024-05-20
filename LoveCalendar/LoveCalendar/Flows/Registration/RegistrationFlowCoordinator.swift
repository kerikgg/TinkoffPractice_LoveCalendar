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
        let registrationViewController = moduleFactory.makeRegistrationModule(
            viewModel: RegistrationViewModel(firestoreService: FirestoreService.shared)
        )
        registrationViewController.completionHandler = { [weak self] registrationState in
            guard let self else { return }
            switch registrationState {
            case .back:
                self.flowCompletionHandler?(.back)
            case .register:
                self.flowCompletionHandler?(.next)
            }
        }
        router.push(registrationViewController, animated: true)
    }
}
