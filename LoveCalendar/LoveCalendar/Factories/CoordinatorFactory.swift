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
        coordinatorFactory: any CoordinatorFactoryProtocol,
        moduleFactory: any ModuleFactoryProtocol
    ) -> AppCoordinator {
        AppCoordinator(
            router: router,
            coordinatorFactory: coordinatorFactory,
            moduleFactory: moduleFactory
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
    
    func makeTabBarCoordinator(
        controller: TabBarDelegate,
        router: any RouterProtocol,
        coordinatorFactory: any CoordinatorFactoryProtocol,
        moduleFactory: any ModuleFactoryProtocol
    ) -> TabBarFlowCoordinator {
        TabBarFlowCoordinator(
            controller: controller,
            router: router,
            coordinatorFactory: coordinatorFactory,
            moduleFactory: moduleFactory
        )
    }

    func makeCalendarCoordinator(
        router: any RouterProtocol,
        coordinatorFactory: any CoordinatorFactoryProtocol,
        moduleFactory: any ModuleFactoryProtocol
    ) -> CalendarFlowCoordinator {
        CalendarFlowCoordinator(
            router: router,
            coordinatorFactory: coordinatorFactory,
            moduleFactory: moduleFactory
        )
    }

    func makeWishlistCoordinator(
        router: any RouterProtocol,
        coordinatorFactory: any CoordinatorFactoryProtocol,
        moduleFactory: any ModuleFactoryProtocol
    ) -> WishlistCoordinator {
        WishlistCoordinator(
            router: router,
            coordinatorFactory: coordinatorFactory,
            moduleFactory: moduleFactory
        )
    }

    func makeMainCoordinator(
        router: any RouterProtocol,
        coordinatorFactory: any CoordinatorFactoryProtocol,
        moduleFactory: any ModuleFactoryProtocol
    ) -> MainCoordinator {
        MainCoordinator(
            router: router,
            coordinatorFactory: coordinatorFactory,
            moduleFactory: moduleFactory
        )
    }

    func makeAlbumCoordinator(
        router: any RouterProtocol,
        coordinatorFactory: any CoordinatorFactoryProtocol,
        moduleFactory: any ModuleFactoryProtocol
    ) -> AlbumCoordinator {
        AlbumCoordinator(
            router: router,
            coordinatorFactory: coordinatorFactory,
            moduleFactory: moduleFactory
        )
    }

    func makeProfileCoordinator(
        router: any RouterProtocol,
        coordinatorFactory: any CoordinatorFactoryProtocol,
        moduleFactory: any ModuleFactoryProtocol
    ) -> ProfileCoordinator {
        ProfileCoordinator(
            router: router,
            coordinatorFactory: coordinatorFactory,
            moduleFactory: moduleFactory
        )
    }
}
