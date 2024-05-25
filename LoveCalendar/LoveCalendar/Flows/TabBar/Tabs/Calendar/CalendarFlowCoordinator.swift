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
        let calendarViewController = moduleFactory.makeCalendarModule()
        router.setViewController(calendarViewController)
    }
}
