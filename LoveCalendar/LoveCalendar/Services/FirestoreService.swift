//
//  FirestoreService.swift
//  LoveCalendar
//
//  Created by kerik on 19.05.2024.
//

import Foundation
import FirebaseFirestore

enum FirebaseError: Error {
    case documentDataError, incorrectData, nilData
}

final class FirestoreService: FirestoreServiceProtocol {
    static let shared = FirestoreService()
    private var usersDb: CollectionReference

    private init() {
        self.usersDb = Firestore.firestore().collection("users")
    }

    func setUserData(user: UserModel, completion: @escaping (Result<UserModel, any Error>) -> Void) {
        usersDb.document(user.id).setData([
            "name": user.name,
            "email": user.email
        ]) { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(user))
            }
        }
    }

    func getUserData(userId: String, completion: @escaping (Result<UserModel, any Error>) -> Void) {
        usersDb.document(userId).getDocument { document, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let document, document.exists else {
                completion(.failure(FirebaseError.documentDataError))
                return
            }

            guard let data = document.data() else {
                completion(.failure(FirebaseError.documentDataError))
                return
            }

            guard
                let email = data["email"] as? String,
                let name = data["name"] as? String
            else {
                completion(.failure(FirebaseError.incorrectData))
                return
            }

            let userModel = UserModel(id: userId, name: name, email: email)
            completion(.success(userModel))
        }
    }

    func updateUserData(userId: String, name: String, completion: @escaping ((any Error)?) -> Void) {
        usersDb.document(userId).updateData(["name": name]) { error in
            guard let error else {
                completion(nil)
                return
            }
            print(error.localizedDescription)
            completion(error)
        }
    }
}
