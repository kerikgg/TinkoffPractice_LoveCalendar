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

    func deleteAvatarData(userId: String, completion: @escaping ((any Error)?) -> Void) {
        storage.child(userId).delete { error in
            guard let error else {
                completion(nil)
                return
            }
            print(error.localizedDescription)
            completion(error)
        }
    }

    func updateAvatarData(userId: String, imageData: Data, completion: @escaping ((any Error)?) -> Void) {
        deleteAvatarData(userId: userId) { error in
            if let error {
                completion(error)
            }
        }

        uploadAvatar(userId: userId, imageData: imageData) { error in
            if let error {
                completion(error)
            }
            completion(nil)
        }
    }
}
