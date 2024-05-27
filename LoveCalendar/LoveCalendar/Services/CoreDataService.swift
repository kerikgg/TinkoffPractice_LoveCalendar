//
//  CoreDataService.swift
//  LoveCalendar
//
//  Created by kerik on 20.05.2024.
//

import Foundation
import CoreData

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
}
