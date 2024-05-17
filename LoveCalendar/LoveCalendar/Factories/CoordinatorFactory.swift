//
//  CoordinatorFactory.swift
//  LoveCalendar
//
//  Created by kerik on 29.03.2024.
//

import Foundation

class CoordinatorFactory: CoordinatorFactoryProtocol {
    func makeAppCoordinator(router: any RouterProtocol) -> AppCoordinator {
        AppCoordinator(router: router)
    }
    
    func makeAuthFlowCoordinator(router: any RouterProtocol) -> AuthFlowCoordinator {
        AuthFlowCoordinator(router: router)
    }
    
    func makeRegistrationFlowCoordinator(router: any RouterProtocol) -> RegistrationFlowCoordinator {
        RegistrationFlowCoordinator(router: router)
    }
    
    func makeSignInFlowCoordinator(router: any RouterProtocol) -> SignInFlowCoordinator {
        SignInFlowCoordinator(router: router)
    }
    
    func makeTabBarCoordinator(controller: any TabBarDelegate) -> TabBarFlowCoordinator {
        TabBarFlowCoordinator(controller: controller)
    }
    
    func makeCalendarCoordinator(router: any RouterProtocol) -> CalendarFlowCoordinator {
        CalendarFlowCoordinator(router: router)
    }
    
    func makeWishlistCoordinator(router: any RouterProtocol) -> WishlistCoordinator {
        WishlistCoordinator(router: router)
    }
    
    func makeMainCoordinator(router: any RouterProtocol) -> MainCoordinator {
        MainCoordinator(router: router)
    }
    
    func makeAlbumCoordinator(router: any RouterProtocol) -> AlbumCoordinator {
        AlbumCoordinator(router: router)
    }
    
    func makeProfileCoordinator(router: any RouterProtocol) -> ProfileCoordinator {
        ProfileCoordinator(router: router)
    }
}
