//
//  ProfileCoordinator.swift
//  LoveCalendar
//
//  Created by kerik on 21.04.2024.
//

import Foundation
import UIKit

class ProfileCoordinator: Coordinator {
    private var router: RouterProtocol

    init(router: RouterProtocol) {
        self.router = router
    }

    override func start() {
        showProfile()
    }

    private func showProfile() {
        let profileViewController = moduleFactory.makeProfileModule(
            viewModel: ProfileViewModel(
                firestoreService: FirestoreService.shared,
                storageService: StorageService.shared,
                coreDataService: CoreDataService.shared
            )
        )
        profileViewController.completionHandler = { [weak self] profileStates in
            guard let self else { return }
            switch profileStates {
            case .logOut:
                self.flowCompletionHandler?(.next)
            case .settings:
                // TODO: флоу настроек
                self.showSettings()
            }
        }
        router.setViewController(profileViewController)
    }

    private func showSettings() {
        let settingsViewController = SettingsViewController(viewModel: SettingsViewModel())
        router.push(settingsViewController, animated: true)
//        settingsViewController.completionHandler = { [weak self] settingsStates in
//            switch()
//            self?.flowCompletionHandler?()
//        }
    }
}
