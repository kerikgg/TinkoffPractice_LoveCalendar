//
//  SignInViewModel.swift
//  LoveCalendar
//
//  Created by kerik on 01.04.2024.
//

import Foundation

class SignInViewModel {
    @Published var isSuccessfullyLoggedIn = false
    @Published var validationError: String = ""
    @Published var firebaseError: String = ""
    private let authService = AuthService.shared

    func signInUser(email: String?, password: String?) {
        guard let email, let password else { return }
        validationError = ""
        if email.isEmpty || password.isEmpty {
            validationError = "Поля не должны быть пустыми"
        } else {
            authService.signIn(email: email, password: password) { [weak self] result in
                guard let self else { return }
                switch result {
                case .success:
                    self.isSuccessfullyLoggedIn = true
                case .failure(let error):
                    firebaseError = error.localizedDescription
                }
            }
        }
    }
}