//
//  TabBarFlowCoordinator.swift
//  LoveCalendar
//
//  Created by kerik on 21.04.2024.
//

import UIKit

class TabBarFlowCoordinator: Coordinator {
    private var tabBarDelegate: TabBarDelegate

    init(controller: TabBarDelegate) {
        self.tabBarDelegate = controller
    }

    override func start() {
        tabBarDelegate.onMainFlow = runMainFlow()
        tabBarDelegate.onCalendarFlow = runCalendarFlow()
        tabBarDelegate.onWishlistFlow = runWishlistFlow()
        tabBarDelegate.onAlbumFlow = runAlbumFlow()
        tabBarDelegate.onProfileFlow = runProfileFlow()
        tabBarDelegate.onViewDidAppear = runMainFlow()
    }

    private func runCalendarFlow() -> ((UINavigationController) -> Void) {
        return { [unowned self] navigationController in
            if navigationController.viewControllers.isEmpty {
                let routerWithNC = Router(rootController: navigationController)
                let calendarCoordinator = coordinatorFactory.makeCalendarCoordinator(
                    router: routerWithNC
                )
                self.addCoordinatorDependency(calendarCoordinator)
                calendarCoordinator.start()
            }
        }
    }

    private func runWishlistFlow() -> ((UINavigationController) -> Void) {
        return { [unowned self] navigationController in
            if navigationController.viewControllers.isEmpty {
                let routerWithNC = Router(rootController: navigationController)
                let wishlistCoordinator = coordinatorFactory.makeWishlistCoordinator(
                    router: routerWithNC
                )
                self.addCoordinatorDependency(wishlistCoordinator)
                wishlistCoordinator.start()
            }
        }
    }

    private func runMainFlow() -> ((UINavigationController) -> Void) {
        return { [unowned self] navigationController in
            if navigationController.viewControllers.isEmpty {
                let routerWithNC = Router(rootController: navigationController)
                let mainCoordinator = coordinatorFactory.makeMainCoordinator(
                    router: routerWithNC
                )
                self.addCoordinatorDependency(mainCoordinator)
                mainCoordinator.start()
            }
        }
    }

    private func runAlbumFlow() -> ((UINavigationController) -> Void) {
        return { [unowned self] navigationController in
            if navigationController.viewControllers.isEmpty {
                let routerWithNC = Router(rootController: navigationController)
                let albumCoordinator = coordinatorFactory.makeAlbumCoordinator(
                    router: routerWithNC
                )
                self.addCoordinatorDependency(albumCoordinator)
                albumCoordinator.start()
            }
        }
    }

    private func runProfileFlow() -> ((UINavigationController) -> Void) {
        return { [unowned self] navigationController in
            if navigationController.viewControllers.isEmpty {
                let routerWithNC = Router(rootController: navigationController)
                let profileCoordinator = coordinatorFactory.makeProfileCoordinator(
                    router: routerWithNC
                )
                profileCoordinator.flowCompletionHandler = { [weak self, weak profileCoordinator] _ in
                    guard let self else { return }
                    self.flowCompletionHandler?(nil)
                    self.deleteCoordinatorDependency(profileCoordinator)
                }

                self.addCoordinatorDependency(profileCoordinator)
                profileCoordinator.start()
            }
        }
    }
}
