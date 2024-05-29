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
        albumViewController.completionHandler = { [weak self] albumStates in
            switch albumStates {
            case .detail(let event):
                self?.showDetail(event: event)
            case .add:
                print("add")
            }
        }
        router.setViewController(albumViewController)
    }

    private func showDetail(event: EventModel) {
        let detailViewController = PhotoDetailViewController(event: event)
        detailViewController.modalPresentationStyle = .fullScreen
        router.present(detailViewController, animated: true)
    }
}
