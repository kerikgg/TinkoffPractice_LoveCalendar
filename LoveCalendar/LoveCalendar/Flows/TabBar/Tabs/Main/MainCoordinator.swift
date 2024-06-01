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
        let mainViewController = moduleFactory.makeMainModule(
            viewModel: MainViewModel(
                coreDataService: CoreDataService.shared,
                firestoreService: FirestoreService.shared,
                storageService: StorageService.shared
            )
        )
        mainViewController.completionHandler = { [weak self] mainStates in
            switch mainStates {
            case .add:
                self?.showAddCounter()
            }
        }
        router.setViewController(mainViewController)
    }

    private func showAddCounter() {
        let addCounterViewController = moduleFactory.makeAddCounterModule(
            viewModel: AddCounterViewModel(coreDataService: CoreDataService.shared)
        )
        addCounterViewController.completionHandler = { [weak self] addCounterStates in
            switch addCounterStates {
            case .save:
                self?.router.pop(animated: true)
            case .back:
                self?.flowCompletionHandler?(.back)
            }
        }
        router.push(addCounterViewController, animated: true)
    }
}
