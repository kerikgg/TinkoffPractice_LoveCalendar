//
//  UserCoreData+CoreDataProperties.swift
//  LoveCalendar
//
//  Created by kerik on 20.05.2024.
//
//

import Foundation
import CoreData


extension UserCoreData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserCoreData> {
        return NSFetchRequest<UserCoreData>(entityName: "UserCoreData")
    }

    @NSManaged public var name: String
    @NSManaged public var email: String
    @NSManaged public var avatarData: Data?
    @NSManaged public var id: String

}

extension UserCoreData : Identifiable {

}
