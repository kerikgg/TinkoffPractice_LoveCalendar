//
//  EventCoreData+CoreDataProperties.swift
//  LoveCalendar
//
//  Created by kerik on 28.05.2024.
//
//

import Foundation
import CoreData

// swiftlint:disable all
extension EventCoreData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<EventCoreData> {
        return NSFetchRequest<EventCoreData>(entityName: "EventCoreData")
    }

    @NSManaged public var uid: UUID
    @NSManaged public var title: String
    @NSManaged public var userId: String
    @NSManaged public var photo: Data
    @NSManaged public var date: Date

}

extension EventCoreData : Identifiable {

}
// swiftlint:enable all
