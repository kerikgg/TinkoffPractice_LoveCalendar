//
//  TabBarViewController.swift
//  LoveCalendar
//
//  Created by kerik on 21.04.2024.
//

import UIKit

class TabBarViewController: UITabBarController, TabBarDelegate {
    var onViewDidAppear: ((UINavigationController) -> Void)?
    var onCalendarFlow: ((UINavigationController) -> Void)?
    var onWishlistFlow: ((UINavigationController) -> Void)?
    var onMainFlow: ((UINavigationController) -> Void)?
    var onAlbumFlow: ((UINavigationController) -> Void)?
    var onProfileFlow: ((UINavigationController) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }

    override func viewDidAppear(_ animated: Bool) {
        if let mainController = viewControllers?[2] as? UINavigationController {
            onViewDidAppear?(mainController)
        }
    }
}

extension TabBarViewController {
    private func configure() {
        setupTabs()
        tabBar.unselectedItemTintColor = UIColor.systemGray3
        tabBar.tintColor = UIColor.buttonText
        delegate = self
        tabBar.backgroundColor = .background
//        view.backgroundColor = .white
    }

    private func setupTabs() {
        let calendarController = setupControllerForTabBar(image: UIImage.calendar, title: Strings.Titles.calendar)
        let wishlistController = setupControllerForTabBar(image: UIImage.wish, title: Strings.Titles.wishlist)
        let mainController = setupControllerForTabBar(image: UIImage.main, title: Strings.Titles.main)
        let albumController = setupControllerForTabBar(image: UIImage.album, title: Strings.Titles.album)
        let profileController = setupControllerForTabBar(image: UIImage.profile, title: Strings.Titles.profile)

        setViewControllers(
            [
                calendarController,
                wishlistController,
                mainController,
                albumController,
                profileController
            ], animated: true)

        selectedViewController = mainController
    }

    private func setupControllerForTabBar(image: UIImage, title: String) -> UINavigationController {
        let navigationController = UINavigationController()
        navigationController.tabBarItem.image = image
        navigationController.tabBarItem.title = title

        return navigationController
    }
}

extension TabBarViewController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        guard let controller = viewControllers?[selectedIndex] as? UINavigationController else { return }

        switch selectedIndex {
        case 0:
            onCalendarFlow?(controller)
        case 1:
            onWishlistFlow?(controller)
        case 2:
            onMainFlow?(controller)
        case 3:
            onAlbumFlow?(controller)
        case 4:
            onProfileFlow?(controller)
        default:
            print("Tab bar index out of range")
        }
    }
}
