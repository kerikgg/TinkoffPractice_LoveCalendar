//
//  CalendarService.swift
//  LoveCalendar
//
//  Created by kerik on 28.05.2024.
//

import Foundation

class CalendarService: CalendarServiceProtocol {
    private let coreDataService: CoreDataServiceProtocol
    static let shared = CalendarService()

    private var events: [EventModel]

    private init() {
        // events = CalendarService.setEvents()
        events = []
        coreDataService = CoreDataService.shared
    }

    func addNewEvent(event: EventModel) {
        events.append(event)
    }

    func getEvents() -> [EventModel] {
        events
    }

    func deleteEvent(event: EventModel) {
        events.removeAll(where: { $0.uid == event.uid })
    }
}
