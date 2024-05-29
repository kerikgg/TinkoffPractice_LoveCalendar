//
//  CalendarFlowCoordinator.swift
//  LoveCalendar
//
//  Created by kerik on 21.04.2024.
//

import Foundation

class CalendarFlowCoordinator: Coordinator {
    private var router: RouterProtocol

    init(router: RouterProtocol) {
        self.router = router
    }

    override func start() {
        showCalendar()
    }

    private func showCalendar() {
        let calendarViewController = moduleFactory.makeCalendarModule(
            viewModel: CalendarViewModel(
                coreDataService: CoreDataService.shared
            )
        )
        calendarViewController.completionHandler = { [weak self] calendarStates in
            switch calendarStates {
            case .add(let date):
                self?.showAddEvent(date: date)
            }
        }
        router.setViewController(calendarViewController)
    }

    private func showAddEvent(date: Date) {
        let addEventViewController = moduleFactory.makeAddEventModule(
            viewModel: AddEventViewModel(
                date: date,
                coreDataService: CoreDataService.shared
            )
        )
        addEventViewController.completionHandler = { [weak self] addEventStates in
            switch addEventStates {
            case .save:
                self?.router.pop(animated: true)
            case .back:
                self?.flowCompletionHandler?(.back)
            }
        }
        router.push(addEventViewController, animated: true)
    }
}
