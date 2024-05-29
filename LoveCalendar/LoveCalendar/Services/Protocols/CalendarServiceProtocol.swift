//
//  CalendarServiceProtocol.swift
//  LoveCalendar
//
//  Created by kerik on 28.05.2024.
//

import Foundation

protocol CalendarServiceProtocol {
    func addNewEvent(event: EventModel)
    func getEvents() -> [EventModel]
    func deleteEvent(event: EventModel)
}
