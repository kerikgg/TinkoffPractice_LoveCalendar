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
        container.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error as NSError? {
                print(error, error.userInfo)
            }
        })
        return container
    }()

    private init() {}

    func setUser(user: UserModel) {
        let userCD = UserCoreData(context: context)
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
            return UserModel(id: user.id, name: user.name, email: user.email, avatarData: avatarData)
        } else {
            return UserModel(id: user.id, name: user.name, email: user.email)
        }
    }

    func clearCachedData() {
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
        clearCachedData()
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
}
