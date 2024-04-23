//
//  ModuleFactory.swift
//  LoveCalendar
//
//  Created by kerik on 29.03.2024.
//

import Foundation

class ModuleFactory: ModuleFactoryProtocol {
    func makeAuthModule() -> AuthViewController {
        AuthViewController()
    }

    func makeRegistrationModule(viewModel: RegistrationViewModel) -> RegistrationViewController {
        RegistrationViewController(viewModel: viewModel)
    }

    func makeSignInModule(viewModel: SignInViewModel) -> SignInViewController {
        SignInViewController(viewModel: viewModel)
    }

    func makeTabBarModule() -> TabBarViewController {
        TabBarViewController()
    }

    func makeCalendarModule() -> CalendarViewController {
        CalendarViewController()
    }

    func makeWishlistModule() -> WishlistViewController {
        WishlistViewController()
    }

    func makeMainModule() -> MainViewController {
        MainViewController()
    }

    func makeAlbumModule() -> AlbumViewController {
        AlbumViewController()
    }

    func makeProfileModule(viewModel: ProfileViewModel) -> ProfileViewController {
        ProfileViewController(viewModel: viewModel)
    }
}
