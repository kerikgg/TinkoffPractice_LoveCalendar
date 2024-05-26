//
//  WishCoreData+CoreDataProperties.swift
//  LoveCalendar
//
//  Created by kerik on 26.05.2024.
//
//

import Foundation
import CoreData

// swiftlint:disable all
extension WishCoreData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WishCoreData> {
        return NSFetchRequest<WishCoreData>(entityName: "WishCoreData")
    }

    @NSManaged public var title: String
    @NSManaged public var url: String?
    @NSManaged public var userId: String
    @NSManaged public var uid: UUID

}

extension WishCoreData : Identifiable {

}
// swiftlint:enable all
