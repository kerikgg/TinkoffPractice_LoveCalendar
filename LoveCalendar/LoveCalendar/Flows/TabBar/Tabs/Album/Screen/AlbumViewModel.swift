//
//  AlbumViewModel.swift
//  LoveCalendar
//
//  Created by kerik on 29.05.2024.
//

import Foundation

final class AlbumViewModel {
    private var coreDataService: CoreDataServiceProtocol
    @Published var events: [EventModel]
    private var allEvents: [EventModel]

    init(coreDataService: CoreDataServiceProtocol) {
        self.coreDataService = coreDataService
        self.events = []
        self.allEvents = []
    }

    func loadEvents() {
        do {
            guard let user = try coreDataService.getCachedUser() else { return }
            let events = try coreDataService.getEvents(userId: user.id)
            self.allEvents = events
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

    func filterEvents(with query: String) {
        if query.isEmpty {
            events = allEvents
        } else {
            events = allEvents.filter { $0.title.lowercased().contains(query.lowercased()) }
        }
        sortEventsByDate()
    }

    private func sortEventsByDate() {
        events.sort { $0.date > $1.date }
    }
}
