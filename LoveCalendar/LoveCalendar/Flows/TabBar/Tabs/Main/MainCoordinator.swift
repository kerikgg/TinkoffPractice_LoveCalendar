//
//  MainCoordinator.swift
//  LoveCalendar
//
//  Created by kerik on 21.04.2024.
//

import Foundation

class MainCoordinator: Coordinator {
    private var router: RouterProtocol

    init(router: RouterProtocol) {
        self.router = router
    }

    override func start() {
        showMain()
    }

    private func showMain() {
        let mainViewController = moduleFactory.makeMainModule()
        router.setViewController(mainViewController)
    }
}
