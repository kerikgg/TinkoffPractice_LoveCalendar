//
//  ActivityResponseModel.swift
//  LoveCalendar
//
//  Created by kerik on 01.06.2024.
//

import Foundation

struct ActivityResponseModel: Decodable {
    let id: Int
    let title: String
    let description: String
    let imageUrl: String
}
