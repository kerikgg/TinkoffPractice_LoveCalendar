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
        coordinatorFactory: CoordinatorFactoryProtocol,
        moduleFactory: ModuleFactoryProtocol
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

    func makeSignInFlowCoordinator(
        router: RouterProtocol,
        coordinatorFactory: CoordinatorFactoryProtocol,
        moduleFactory: ModuleFactoryProtocol
    ) -> SignInFlowCoordinator

    func makeTabBarCoordinator(
        controller: TabBarDelegate,
        router: RouterProtocol,
        coordinatorFactory: CoordinatorFactoryProtocol,
        moduleFactory: ModuleFactoryProtocol
    ) -> TabBarFlowCoordinator

    func makeCalendarCoordinator(
        router: RouterProtocol,
        coordinatorFactory: CoordinatorFactoryProtocol,
        moduleFactory: ModuleFactoryProtocol
    ) -> CalendarFlowCoordinator

    func makeWishlistCoordinator(
        router: RouterProtocol,
        coordinatorFactory: CoordinatorFactoryProtocol,
        moduleFactory: ModuleFactoryProtocol
    ) -> WishlistCoordinator

    func makeMainCoordinator(
        router: RouterProtocol,
        coordinatorFactory: CoordinatorFactoryProtocol,
        moduleFactory: ModuleFactoryProtocol
    ) -> MainCoordinator

    func makeAlbumCoordinator(
        router: RouterProtocol,
        coordinatorFactory: CoordinatorFactoryProtocol,
        moduleFactory: ModuleFactoryProtocol
    ) -> AlbumCoordinator

    func makeProfileCoordinator(
        router: RouterProtocol,
        coordinatorFactory: CoordinatorFactoryProtocol,
        moduleFactory: ModuleFactoryProtocol
    ) -> ProfileCoordinator
}
