//
//  PhotoCoreData+CoreDataProperties.swift
//  LoveCalendar
//
//  Created by kerik on 30.05.2024.
//
//

import Foundation
import CoreData

// swiftlint:disable all
extension PhotoCoreData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PhotoCoreData> {
        return NSFetchRequest<PhotoCoreData>(entityName: "PhotoCoreData")
    }

    @NSManaged public var userId: String
    @NSManaged public var uid: UUID
    @NSManaged public var title: String
    @NSManaged public var photo: Data

}

extension PhotoCoreData : Identifiable {

}
// swiftlint:enable all
