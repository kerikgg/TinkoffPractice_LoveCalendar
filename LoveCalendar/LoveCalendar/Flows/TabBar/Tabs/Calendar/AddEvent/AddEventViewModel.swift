//
//  AddEventViewModel.swift
//  LoveCalendar
//
//  Created by kerik on 28.05.2024.
//

import Foundation

final class AddEventViewModel {
    private let coreDataService: CoreDataServiceProtocol
    private var date: Date

    init(date: Date, coreDataService: CoreDataServiceProtocol) {
        self.coreDataService = coreDataService
        self.date = date
    }

    func addNewEvent(event: EventModel) {
        do {
            guard let user = try coreDataService.getCachedUser() else { return }
            coreDataService.setEvent(userId: user.id, event: event)
        } catch {
            print(error.localizedDescription)
        }
    }
//    private var calendarService: CalendarServiceProtocol
//    private var date: Date
//
//    init(date: Date, calendarService: CalendarServiceProtocol) {
//        self.date = date
//        self.calendarService = calendarService
//    }
//
//    func addEvent(event: EventModel) {
//        calendarService.addNewEvent(event: event)
//    }
//
    func getPickedDate() -> Date {
        return date
    }
}
