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
            case .add:
                self?.showAddPhoto()
            }
        }
        router.setViewController(albumViewController)
    }

    private func showAddPhoto() {
        let addPhotoViewController = moduleFactory.makeAddPhotoModule(
            viewModel: AddPhotoViewModel(
                coreDataService: CoreDataService.shared
            )
        )
        addPhotoViewController.completionHandler = { [weak self] addPhotoStates in
            switch addPhotoStates {
            case .save:
                self?.router.pop(animated: true)
            case .back:
                self?.flowCompletionHandler?(.back)
            }
        }
        router.push(addPhotoViewController, animated: true)
    }
}
