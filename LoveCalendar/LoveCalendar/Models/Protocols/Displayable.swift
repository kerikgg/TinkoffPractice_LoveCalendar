//
//  File.swift
//  LoveCalendar
//
//  Created by kerik on 30.05.2024.
//

import Foundation

protocol Displayable {
    var imageData: Data { get }
    var displayTitle: String { get }
    var displayDate: Date? { get }
}

extension EventModel: Displayable {
    var imageData: Data { return self.image }
    var displayTitle: String { return self.title }
    var displayDate: Date? { return self.date }
}

extension PhotoModel: Displayable {
    var imageData: Data { return self.image }
    var displayTitle: String { return self.title }
    var displayDate: Date? { return nil }
}
