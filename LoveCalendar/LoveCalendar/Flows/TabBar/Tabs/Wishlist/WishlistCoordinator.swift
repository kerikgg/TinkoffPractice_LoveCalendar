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
        let wishlistViewController = moduleFactory.makeWishlistModule(
            viewModel: WishlistViewModel(coreDataService: CoreDataService.shared)
        )
        wishlistViewController.completionHandler = { [weak self] wishlistStates in
            switch wishlistStates {
            case .add:
                self?.showAddWish()
            }
        }
        router.setViewController(wishlistViewController)
    }

    private func showAddWish() {
        let addWishViewController = moduleFactory.makeAddWishModule(
            viewModel: AddWishViewModel(coreDataService: CoreDataService.shared)
        )
        addWishViewController.completionHandler = { [weak self] addWishStates in
            switch addWishStates {
            case .save:
                self?.router.pop(animated: true)
            case .back:
                self?.flowCompletionHandler?(.back)
            }
        }
        router.push(addWishViewController, animated: true)
    }
}
