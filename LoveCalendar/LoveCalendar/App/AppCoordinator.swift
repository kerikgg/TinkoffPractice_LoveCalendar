//
//  AppCoordinator.swift
//  LoveCalendar
//
//  Created by kerik on 29.03.2024.
//

import Foundation

class AppCoordinator: Coordinator {
    private var router: RouterProtocol
    private let authService: AuthService

    init(router: RouterProtocol) {
        self.router = router
        self.authService = AuthService.shared
    }

    override func start() {
        if authService.currentUser == nil {
            runAuthFlow()
        } else {
            runMainFlow()
        }
    }

    private func runAuthFlow() {
        let authFlowCoordinator = coordinatorFactory.makeAuthFlowCoordinator(
            router: router
        )
        addCoordinatorDependency(authFlowCoordinator)
        authFlowCoordinator.start()
        authFlowCoordinator.flowCompletionHandler = { [weak self] in
            guard let self else { return }
            self.runMainFlow()
            self.deleteCoordinatorDependency(authFlowCoordinator)
        }
    }

    private func runMainFlow() {
        let tabBarViewController = moduleFactory.makeTabBarModule()
        let tabBarFlowCoordinator = coordinatorFactory.makeTabBarCoordinator(
            controller: tabBarViewController
        )
        addCoordinatorDependency(tabBarFlowCoordinator)
        tabBarFlowCoordinator.flowCompletionHandler = { [weak self] in
            guard let self else { return }
            deleteCoordinatorDependency(tabBarFlowCoordinator)
            runAuthFlow()
        }
        router.setViewController(tabBarViewController, isNavigationBarHidden: true)
        tabBarFlowCoordinator.start()
    }
}
