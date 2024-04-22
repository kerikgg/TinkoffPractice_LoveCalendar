//
//  WishlistCoordinator.swift
//  LoveCalendar
//
//  Created by kerik on 21.04.2024.
//

import Foundation

class WishlistCoordinator: Coordinator {
    private var router: RouterProtocol
    private var coordinatorFactory: CoordinatorFactoryProtocol
    private var moduleFactory: ModuleFactoryProtocol

    init(router: RouterProtocol, coordinatorFactory: CoordinatorFactoryProtocol, moduleFactory: ModuleFactoryProtocol) {
        self.router = router
        self.coordinatorFactory = coordinatorFactory
        self.moduleFactory = moduleFactory
    }

    override func start() {
        showWishlist()
    }

    private func showWishlist() {
        let wishlistViewController = moduleFactory.makeWishlistModule()
        router.setViewController(wishlistViewController)
    }
}
