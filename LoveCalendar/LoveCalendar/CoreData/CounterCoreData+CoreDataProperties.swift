//
//  CounterCoreData+CoreDataProperties.swift
//  LoveCalendar
//
//  Created by kerik on 31.05.2024.
//
//

import Foundation
import CoreData

// swiftlint:disable all
extension CounterCoreData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CounterCoreData> {
        return NSFetchRequest<CounterCoreData>(entityName: "CounterCoreData")
    }

    @NSManaged public var userId: String
    @NSManaged public var uid: UUID
    @NSManaged public var partnerName: String
    @NSManaged public var image: Data
    @NSManaged public var startDate: Date

}

extension CounterCoreData : Identifiable {

}
// swiftlint:enable all
