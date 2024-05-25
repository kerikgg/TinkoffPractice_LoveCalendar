//
//  AuthService.swift
//  LoveCalendar
//
//  Created by kerik on 31.03.2024.
//

import Foundation
import FirebaseAuth

class AuthService {
    var currentUser: User? {
        return auth.currentUser
    }
    private let auth: Auth

    static let shared = AuthService()

    init() {
        auth = Auth.auth()
    }

    func signUp(
        email: String,
        password: String,
        completion: @escaping (Result<User, Error>) -> Void
    ) {
        auth.createUser(withEmail: email, password: password) { result, error in
            if let result = result {
                completion(.success(result.user))
            } else if let error {
                completion(.failure(error))
            }
        }
    }

    func signIn(
        email: String,
        password: String,
        completion: @escaping (Result<User, Error>) -> Void
    ) {
        auth.signIn(withEmail: email, password: password) { result, error in
            if let result = result {
                completion(.success(result.user))
            } else if let error = error {
                completion(.failure(error))
            }
        }
    }

    func logOut() {
        do {
            try auth.signOut()
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
}
