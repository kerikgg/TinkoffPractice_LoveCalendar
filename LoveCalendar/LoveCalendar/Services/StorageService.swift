//
//  StorageService.swift
//  LoveCalendar
//
//  Created by kerik on 19.05.2024.
//

import Foundation
import FirebaseStorage

class StorageService: StorageServiceProtocol {
    static let shared = StorageService()
    private let storage: StorageReference

    init() {
        self.storage = Storage.storage().reference(withPath: "avatars")
    }

    func uploadAvatar(userId: String, imageData: Data, completion: @escaping ((any Error)?) -> Void) {
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpg"

        storage.child(userId).putData(imageData, metadata: metadata) { _, error in
            guard let error else {
                completion(nil)
                return
            }
            completion(error)
        }
    }
    
    func getAvatar(userId: String, completion: @escaping (Result<Data, any Error>) -> Void) {
        storage.child(userId).getData(maxSize: .max) { result in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
