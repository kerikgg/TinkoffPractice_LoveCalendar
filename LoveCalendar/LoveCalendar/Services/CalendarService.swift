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
    
//    func getEvents() -> [EventModel] {
//        return events
//    }

    func getEvents() -> [EventModel] {
        events
    }

    func deleteEvent(event: EventModel) {
        events.removeAll(where: { $0.uid == event.uid })
    }


//    private static func setEvents() -> [EventModel] {
//        let currentDate = Date()
//        let calendar = Calendar.current
//        let day = calendar.date(byAdding: .month, value: -1, to: currentDate)
//
//        let secondDay = calendar.date(byAdding: .day, value: -5, to: currentDate)
//
//        let events: [EventModel] = [
//            .init(uid: UUID(), title: "1", date: Date()),
//            .init(uid: UUID(), title: "3", date: secondDay ?? Date()),
//            .init(uid: UUID(), title: "2", date: day ?? Date())
//        ]
//
//        return events
//    }
}
