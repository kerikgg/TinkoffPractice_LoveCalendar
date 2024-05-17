//
//  SceneDelegate.swift
//  LoveCalendar
//
//  Created by kerik on 26.03.2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    var appCoordinator: AppCoordinator?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        let router = Router(rootController: UINavigationController())
        let coordinatorFactory = CoordinatorFactory()

        appCoordinator = coordinatorFactory.makeAppCoordinator(router: router)

        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = router.showRootController()
        appCoordinator?.start()
        window?.makeKeyAndVisible()
    }
}
