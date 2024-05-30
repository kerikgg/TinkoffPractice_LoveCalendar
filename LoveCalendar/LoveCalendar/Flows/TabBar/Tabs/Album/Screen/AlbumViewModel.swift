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
    @Published var photos: [PhotoModel]
    private var allPhotos: [PhotoModel]

    var hasEvents: Bool {
        return !events.isEmpty
    }

    var hasPhotos: Bool {
        return !photos.isEmpty
    }

    var numberOfSections: Int {
        var count = 0
        if hasEvents { count += 1 }
        if hasPhotos { count += 1 }
        return count
    }

    init(coreDataService: CoreDataServiceProtocol) {
        self.coreDataService = coreDataService
        self.events = []
        self.allEvents = []
        self.photos = []
        self.allPhotos = []
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

    func loadPhotos() {
        do {
            guard let user = try coreDataService.getCachedUser() else { return }
            let photos = try coreDataService.getPhotos(userId: user.id)
            self.allPhotos = photos
            self.photos = photos
        } catch {
            print(error.localizedDescription)
        }
    }

    func delete(model: PhotoModel) {
        do {
            guard let user = try coreDataService.getCachedUser() else { return }
            coreDataService.deletePhoto(userId: user.id, photo: model)
            loadPhotos()
        } catch {
            print(error.localizedDescription)
        }
    }

    func filter(with query: String) {
        if query.isEmpty {
            events = allEvents
            photos = allPhotos
        } else {
            events = allEvents.filter { $0.title.lowercased().contains(query.lowercased()) }
            photos = allPhotos.filter { $0.title.lowercased().contains(query.lowercased()) }
        }
        sortEventsByDate()
    }

    private func sortEventsByDate() {
        events.sort { $0.date > $1.date }
    }
}
