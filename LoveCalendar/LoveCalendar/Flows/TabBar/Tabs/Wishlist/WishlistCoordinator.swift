//
//  WishlistCoordinator.swift
//  LoveCalendar
//
//  Created by kerik on 21.04.2024.
//

import Foundation

class WishlistCoordinator: Coordinator {
    private var router: RouterProtocol

    init(router: RouterProtocol) {
        self.router = router
    }

    override func start() {
        showWishlist()
    }

    private func showWishlist() {
        let wishlistViewController = moduleFactory.makeWishlistModule()
        router.setViewController(wishlistViewController)
    }
}
