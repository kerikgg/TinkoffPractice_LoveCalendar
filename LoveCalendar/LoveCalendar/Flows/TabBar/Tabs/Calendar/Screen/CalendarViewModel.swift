//
//  CalendarVIewModel.swift
//  LoveCalendar
//
//  Created by kerik on 27.05.2024.
//

import Foundation

final class CalendarViewModel {
    private var coreDataService: CoreDataServiceProtocol
    @Published var events: [EventModel]

    init(coreDataService: CoreDataServiceProtocol) {
        self.coreDataService = coreDataService
        self.events = []
    }

    func loadEvents() {
        do {
            guard let user = try coreDataService.getCachedUser() else { return }
            let events = try coreDataService.getEvents(userId: user.id)
            self.events = events
            sortEventsByDate()
        } catch {
            print(error.localizedDescription)
        }
    }

    func delete(model: EventModel) {
        do {
            guard let user = try coreDataService.getCachedUser() else { return }
            coreDataService.deleteEvent(userId: user.id, event: model)
            loadEvents()
        } catch {
            print(error.localizedDescription)
        }
    }

    private func sortEventsByDate() {
        events.sort { $0.date > $1.date }
    }
}
