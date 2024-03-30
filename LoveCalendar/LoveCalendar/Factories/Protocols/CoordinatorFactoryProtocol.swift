//
//  CoordinatorFactoryProtocol.swift
//  LoveCalendar
//
//  Created by kerik on 29.03.2024.
//

import Foundation

protocol CoordinatorFactoryProtocol {
    func makeAppCoordinator(
        router: RouterProtocol,
        coordinatorFactory: CoordinatorFactoryProtocol
    ) -> AppCoordinator

    func makeAuthFlowCoordinator(
        router: RouterProtocol,
        coordinatorFactory: CoordinatorFactoryProtocol,
        moduleFactory: ModuleFactoryProtocol
    ) -> AuthFlowCoordinator

    func makeRegistrationFlowCoordinator(
        router: RouterProtocol,
        coordinatorFactory: CoordinatorFactoryProtocol,
        moduleFactory: ModuleFactoryProtocol
    ) -> RegistrationFlowCoordinator
}
