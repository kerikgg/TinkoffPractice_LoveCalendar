//
//  AlbumCoordinator.swift
//  LoveCalendar
//
//  Created by kerik on 21.04.2024.
//

import Foundation

class AlbumCoordinator: Coordinator {
    private var router: RouterProtocol
    private var coordinatorFactory: CoordinatorFactoryProtocol
    private var moduleFactory: ModuleFactoryProtocol

    init(router: RouterProtocol, coordinatorFactory: CoordinatorFactoryProtocol, moduleFactory: ModuleFactoryProtocol) {
        self.router = router
        self.coordinatorFactory = coordinatorFactory
        self.moduleFactory = moduleFactory
    }

    override func start() {
        showAlbum()
    }

    private func showAlbum() {
        let albumViewController = moduleFactory.makeAlbumModule()
        router.setViewController(albumViewController)
    }
}
