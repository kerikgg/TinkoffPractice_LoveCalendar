//
//  CoreDataServiceProtocol.swift
//  LoveCalendar
//
//  Created by kerik on 20.05.2024.
//

import Foundation

protocol CoreDataServiceProtocol {
    func setUser(user: UserModel)
    func getCachedUser() throws -> UserModel?
    func clearCachedData()
    func updateUserData(user: UserModel)
}
