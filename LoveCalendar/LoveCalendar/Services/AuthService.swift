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

    private let auth = Auth.auth()

    func signUp(
        email: String,
        password: String,
        complition: @escaping (Result<User, Error>) -> Void
    ) {
        auth.createUser(withEmail: email, password: password) { result, error in
            if let result = result {
                complition(.success(result.user))
            } else if let error {
                complition(.failure(error))
            }
        }
    }

    func signIn(
        email: String,
        password: String,
        complition: @escaping (Result<User, Error>) -> Void
    ) {
        auth.signIn(withEmail: email, password: password) { result, error in
            if let result = result {
                complition(.success(result.user))
            } else if let error = error {
                complition(.failure(error))
            }
        }
    }
}
