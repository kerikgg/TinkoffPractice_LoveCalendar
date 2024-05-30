//
//  CoreDataService.swift
//  LoveCalendar
//
//  Created by kerik on 20.05.2024.
//

import UIKit
import CoreData

enum EventError: Error {
    case invalidImageData
}

final class CoreDataService: CoreDataServiceProtocol {
    static let shared = CoreDataService()

    private var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }

    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CoreData")
        container.loadPersistentStores(completionHandler: { _, error in
            if let error = error as NSError? {
                print(error, error.userInfo)
            }
        })
        return container
    }()

    private init() {}

    private func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                if let error = error as NSError? {
                    print(error, error.userInfo)
                }
            }
        }
    }

    // MARK: - User methods
    func setUser(user: UserModel) {
        let userCD = UserCoreData(context: context)
        userCD.uid = user.id
        userCD.email = user.email
        userCD.name = user.name
        userCD.avatarData = user.avatarData
        saveContext()
    }
    
    func getCachedUser() throws -> UserModel? {
        let userCDFetchRequest = UserCoreData.fetchRequest()
        userCDFetchRequest.fetchLimit = 1
        let users = try context.fetch(userCDFetchRequest)

        guard let user = users.first else { return nil}
        if let avatarData = user.avatarData {
            return UserModel(id: user.uid, name: user.name, email: user.email, avatarData: avatarData)
        } else {
            return UserModel(id: user.uid, name: user.name, email: user.email)
        }
    }

    func clearCachedUserData() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "UserCoreData")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

        do {
            try context.execute(deleteRequest)
            saveContext()
        } catch {
            print("\(error)")
        }
    }
    
    func updateUserData(user: UserModel) {
        clearCachedUserData()
        setUser(user: user)
    }

    // MARK: - Wish methods
    func setWish(userId: String, wish: WishlistCellModel) {
        let wishCd = WishCoreData(context: context)
        wishCd.userId = userId
        wishCd.title = wish.title
        wishCd.url = wish.url
        wishCd.uid = wish.uid
        saveContext()
    }

    func deleteWish(userId: String, wish: WishlistCellModel) {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = WishCoreData.fetchRequest()
        fetchRequest.predicate = NSPredicate(
            format: "userId == %@ AND title == %@ AND uid == %@", userId, wish.title, wish.uid as CVarArg
        )

        do {
            let wishes = try context.fetch(fetchRequest)

            for object in wishes {
                guard let wishToDelete = object as? NSManagedObject else { continue }
                context.delete(wishToDelete)
            }
            saveContext()
        } catch {
            print("Failed to delete wish: \(error)")
        }
    }

    func getWishes(userId: String) throws -> [WishlistCellModel] {
        let fetchRequest: NSFetchRequest<WishCoreData> = WishCoreData.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "userId == %@", userId)
        
        let wishes = try context.fetch(fetchRequest)
        return wishes.map { wish in
            WishlistCellModel(title: wish.title, url: wish.url ?? "", uid: wish.uid)
        }
    }

    func clearCachedWishesData() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "WishCoreData")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

        do {
            try context.execute(deleteRequest)
            saveContext()
        } catch {
            print("\(error)")
        }
    }

    // MARK: - Event methods
    func setEvent(userId: String, event: EventModel) {
        let eventCd = EventCoreData(context: context)
        eventCd.userId = userId
        eventCd.title = event.title
        eventCd.uid = event.uid
        eventCd.date = event.date
        eventCd.photo = event.image
        saveContext()
    }

    func deleteEvent(userId: String, event: EventModel) {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = EventCoreData.fetchRequest()
        fetchRequest.predicate = NSPredicate(
            format: "userId == %@ AND title == %@ AND uid == %@", userId, event.title, event.uid as CVarArg
        )

        do {
            let events = try context.fetch(fetchRequest)

            for object in events {
                guard let eventToDelete = object as? NSManagedObject else { continue }
                context.delete(eventToDelete)
            }
            saveContext()
        } catch {
            print("Failed to delete event: \(error)")
        }
    }

    func getEvents(userId: String) throws -> [EventModel] {
        let fetchRequest: NSFetchRequest<EventCoreData> = EventCoreData.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "userId == %@", userId)

        let events = try context.fetch(fetchRequest)
        return events.map { event in
            EventModel(uid: event.uid, title: event.title, date: event.date, image: event.photo)
        }
    }

    func clearCachedEventsData() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "EventCoreData")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

        do {
            try context.execute(deleteRequest)
            saveContext()
        } catch {
            print("\(error)")
        }
    }

    // MARK: - Photo methods
    func setPhoto(userId: String, photo: PhotoModel) {
        let photoCD = PhotoCoreData(context: context)
        photoCD.userId = userId
        photoCD.uid = photo.uid
        photoCD.title = photo.title
        photoCD.photo = photo.image
        saveContext()
    }

    func deletePhoto(userId: String, photo: PhotoModel) {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = PhotoCoreData.fetchRequest()
        fetchRequest.predicate = NSPredicate(
            format: "userId == %@ AND uid == %@", userId, photo.uid as CVarArg
        )

        do {
            let photos = try context.fetch(fetchRequest)

            for object in photos {
                guard let photoToDelete = object as? NSManagedObject else { continue }
                context.delete(photoToDelete)
            }
            saveContext()
        } catch {
            print("Failed to delete photo: \(error)")
        }
    }

    func getPhotos(userId: String) throws -> [PhotoModel] {
        let fetchRequest: NSFetchRequest<PhotoCoreData> = PhotoCoreData.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "userId == %@", userId)

        let photos = try context.fetch(fetchRequest)
        return photos.map { photo in
            PhotoModel(uid: photo.uid, title: photo.title, image: photo.photo)
        }
    }

    func clearCachedPhotosData() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "PhotoCoreData")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

        do {
            try context.execute(deleteRequest)
            saveContext()
        } catch {
            print("\(error)")
        }
    }
}
