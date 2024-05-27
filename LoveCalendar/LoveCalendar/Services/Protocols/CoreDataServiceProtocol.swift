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

    func setWish(userId: String, wish: WishlistCellModel)
    func deleteWish(userId: String, wish: WishlistCellModel)
    func getWishes(userId: String) throws -> [WishlistCellModel]

    func clearCachedWishesData()
}
