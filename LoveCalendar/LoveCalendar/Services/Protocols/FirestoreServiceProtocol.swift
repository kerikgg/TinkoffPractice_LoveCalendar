//
//  FirestoreServiceProtocol.swift
//  LoveCalendar
//
//  Created by kerik on 19.05.2024.
//

import Foundation

protocol FirestoreServiceProtocol {
    func setUserData(user: UserModel, completion: @escaping (Result<UserModel, Error>) -> Void)
    func getUserData(userId: String, completion: @escaping (Result<UserModel, Error>) -> Void)
    func updateUserData(userId: String, name: String, completion: @escaping (Error?) -> Void)
}
