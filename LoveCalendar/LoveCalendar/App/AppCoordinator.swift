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
    private var moduleFactory: ModuleFactoryProtocol
    private var isLogged = true // mock

    init(router: RouterProtocol, coordinatorFactory: CoordinatorFactoryProtocol, moduleFactory: ModuleFactoryProtocol) {
        self.router = router
        self.coordinatorFactory = coordinatorFactory
        self.moduleFactory = moduleFactory
    }

    override func start() {
        if isLogged {
            runMainFlow()
        } else {
            runAuthFlow()
        }
    }

    private func runAuthFlow() {
        let authFlowCoordinator = coordinatorFactory.makeAuthFlowCoordinator(
            router: router,
            coordinatorFactory: coordinatorFactory,
            moduleFactory: moduleFactory)
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
            controller: tabBarViewController,
            router: router,
            coordinatorFactory: coordinatorFactory,
            moduleFactory: moduleFactory)
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
