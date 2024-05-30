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

    func makeCalendarModule(viewModel: CalendarViewModel) -> CalendarViewController
    func makeWishlistModule(viewModel: WishlistViewModel) -> WishlistViewController
    func makeMainModule() -> MainViewController
    func makeAlbumModule(viewModel: AlbumViewModel) -> AlbumViewController
    func makeProfileModule(viewModel: ProfileViewModel) -> ProfileViewController
    func makeSettingsModule(viewModel: SettingsViewModel) -> SettingsViewController

    func makeEditProfileModule(viewModel: EditProfileViewModel) -> EditProfileViewController
    func makeAddWishModule(viewModel: AddWishViewModel) -> AddWishViewController
    func makeAddEventModule(viewModel: AddEventViewModel) -> AddEventViewController
    func makeAddPhotoModule(viewModel: AddPhotoViewModel) -> AddPhotoViewController
}
