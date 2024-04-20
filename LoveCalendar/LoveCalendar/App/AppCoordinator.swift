//
//  AppCoordinator.swift
//  LoveCalendar
//
//  Created by kerik on 29.03.2024.
//

import Foundation

class AppCoordinator: Coordinator {
    private var router: RouterProtocol
    private var coordinatorFactory: CoordinatorFactoryProtocol
    private var isLogged = false // mock

    init(router: RouterProtocol, coordinatorFactory: CoordinatorFactoryProtocol) {
        self.router = router
        self.coordinatorFactory = coordinatorFactory
    }

    override func start() {
        if isLogged {
            runMainFlow()
        } else {
            runAuthFlow()
        }
    }

    private func runAuthFlow() {
        let authFlowCoordinator = AuthFlowCoordinator(
            router: router,
            coordinatorFactory: coordinatorFactory,
            moduleFactory: ModuleFactory()
        )
        addCoordinatorDependency(authFlowCoordinator)
        authFlowCoordinator.start()
    }

    private func runMainFlow() {
        print("test")
    }
}
