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
    func clearCachedUserData()
    func updateUserData(user: UserModel)

    func setWish(userId: String, wish: WishListModel)
    func deleteWish(userId: String, wish: WishListModel)
    func getWishes(userId: String) throws -> [WishListModel]
    func clearCachedWishesData()

    func setEvent(userId: String, event: EventModel)
    func deleteEvent(userId: String, event: EventModel)
    func getEvents(userId: String) throws -> [EventModel]
    func clearCachedEventsData()

    func setPhoto(userId: String, photo: PhotoModel)
    func deletePhoto(userId: String, photo: PhotoModel)
    func getPhotos(userId: String) throws -> [PhotoModel]
    func clearCachedPhotosData()

    func setCounter(userId: String, counter: CounterModel)
    func getCounter(userId: String) throws -> Result<CounterModel, Error>
    func clearCachedCounterData()
}
