//
//  SettingsFlowCoordinator.swift
//  LoveCalendar
//
//  Created by kerik on 24.05.2024.
//

import Foundation

final class SettingsFlowCoordinator: Coordinator {
    private var router: RouterProtocol

    init(router: RouterProtocol) {
        self.router = router
    }

    override func start() {
        showSettings()
    }

    private func showSettings() {
        let settingsViewController = moduleFactory.makeSettingsModule(viewModel: SettingsViewModel())
        settingsViewController.completionHandler = { [weak self] states in
            guard let self else { return }
            switch states {
            case .edit:
                self.showEditProfile()
            case .back:
                self.flowCompletionHandler?(.back)
            case .theme:
                break
            }
        }
        router.push(settingsViewController, animated: true)
    }

    private func showEditProfile() {
        let editProfileViewController = moduleFactory.makeEditProfileModule(
            viewModel: EditProfileViewModel(
                firestoreService: FirestoreService.shared,
                storageService: StorageService.shared,
                coreDataService: CoreDataService.shared
            )
        )
        editProfileViewController.completionHandler = { [weak self] editProfileState in
            guard let self else { return }
            switch editProfileState {
            case .back:
                self.router.popToRootController(animated: true)
                self.flowCompletionHandler?(.back)
            case .save:
                self.router.pop(animated: true)
                self.flowCompletionHandler?(.back)
            }
        }
        router.push(editProfileViewController, animated: true)
    }
}
