//
//  AlbumCoordinator.swift
//  LoveCalendar
//
//  Created by kerik on 21.04.2024.
//

import Foundation

class AlbumCoordinator: Coordinator {
    private var router: RouterProtocol

    init(router: RouterProtocol) {
        self.router = router
    }

    override func start() {
        showAlbum()
    }

    private func showAlbum() {
        let albumViewController = moduleFactory.makeAlbumModule(
            viewModel: AlbumViewModel(
                coreDataService: CoreDataService.shared
            )
        )
        router.setViewController(albumViewController)
    }
}
