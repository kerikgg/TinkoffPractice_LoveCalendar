//
//  CoordinatorFactory.swift
//  LoveCalendar
//
//  Created by kerik on 29.03.2024.
//

import Foundation

class CoordinatorFactory: CoordinatorFactoryProtocol {
    func makeAppCoordinator(
        router: any RouterProtocol,
        coordinatorFactory: any CoordinatorFactoryProtocol
    ) -> AppCoordinator {
        AppCoordinator(
            router: router,
            coordinatorFactory: coordinatorFactory
        )
    }
    
    func makeAuthFlowCoordinator(
        router: any RouterProtocol,
        coordinatorFactory: any CoordinatorFactoryProtocol,
        moduleFactory: any ModuleFactoryProtocol
    ) -> AuthFlowCoordinator {
        AuthFlowCoordinator(
            router: router,
            coordinatorFactory: coordinatorFactory,
            moduleFactory: moduleFactory
        )
    }

    func makeRegistrationFlowCoordinator(
        router: any RouterProtocol,
        coordinatorFactory: any CoordinatorFactoryProtocol,
        moduleFactory: any ModuleFactoryProtocol
    ) -> RegistrationFlowCoordinator {
        RegistrationFlowCoordinator(
            router: router,
            coordinatorFactory: coordinatorFactory,
            moduleFactory: moduleFactory
        )
    }

    func makeSignInFlowCoordinator(
        router: any RouterProtocol,
        coordinatorFactory: any CoordinatorFactoryProtocol,
        moduleFactory: any ModuleFactoryProtocol
    ) -> SignInFlowCoordinator {
        SignInFlowCoordinator(
            router: router,
            coordinatorFactory: coordinatorFactory,
            moduleFactory: moduleFactory
        )
    }
}
