//
//  StorageServiceProtocol.swift
//  LoveCalendar
//
//  Created by kerik on 19.05.2024.
//

import Foundation

protocol StorageServiceProtocol {
    func uploadAvatar(userId: String, imageData: Data, completion: @escaping(Error?) -> Void)
    func getAvatar(userId: String, completion: @escaping(Result<Data, Error>) -> Void)
}
