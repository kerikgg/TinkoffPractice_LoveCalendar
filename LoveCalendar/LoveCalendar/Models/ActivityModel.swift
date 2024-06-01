//
//  Activity.swift
//  LoveCalendar
//
//  Created by kerik on 01.06.2024.
//

import Foundation

struct ActivityModel: Decodable {
    let id: Int
    let title: String
    let description: String
    let image: Data
}
