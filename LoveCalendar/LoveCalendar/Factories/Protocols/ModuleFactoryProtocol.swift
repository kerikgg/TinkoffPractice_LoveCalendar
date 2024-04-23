//
//  ModuleFactoryProtocol.swift
//  LoveCalendar
//
//  Created by kerik on 29.03.2024.
//

import Foundation

protocol ModuleFactoryProtocol {
    func makeAuthModule() -> AuthViewController

    func makeRegistrationModule(viewModel: RegistrationViewModel) -> RegistrationViewController

    func makeSignInModule(viewModel: SignInViewModel) -> SignInViewController

    func makeTabBarModule() -> TabBarViewController

    func makeCalendarModule() -> CalendarViewController
    func makeWishlistModule() -> WishlistViewController
    func makeMainModule() -> MainViewController
    func makeAlbumModule() -> AlbumViewController
    func makeProfileModule(viewModel: ProfileViewModel) -> ProfileViewController
}
