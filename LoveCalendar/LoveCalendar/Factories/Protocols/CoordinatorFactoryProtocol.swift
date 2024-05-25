//
//  CoordinatorFactoryProtocol.swift
//  LoveCalendar
//
//  Created by kerik on 29.03.2024.
//

import Foundation

protocol CoordinatorFactoryProtocol {
    func makeAppCoordinator(router: RouterProtocol) -> AppCoordinator

    func makeAuthFlowCoordinator(router: RouterProtocol) -> AuthFlowCoordinator

    func makeRegistrationFlowCoordinator(router: RouterProtocol) -> RegistrationFlowCoordinator

    func makeSignInFlowCoordinator(router: RouterProtocol) -> SignInFlowCoordinator

    func makeTabBarCoordinator(controller: TabBarDelegate) -> TabBarFlowCoordinator

    func makeCalendarCoordinator(router: RouterProtocol) -> CalendarFlowCoordinator

    func makeWishlistCoordinator(router: RouterProtocol) -> WishlistCoordinator

    func makeMainCoordinator(router: RouterProtocol) -> MainCoordinator

    func makeAlbumCoordinator(router: RouterProtocol) -> AlbumCoordinator

    func makeProfileCoordinator(router: RouterProtocol) -> ProfileCoordinator

    func makeSettingsCoordinator(router: RouterProtocol) -> SettingsFlowCoordinator
}
