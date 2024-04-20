//
//  RegistrationViewModel.swift
//  LoveCalendar
//
//  Created by kerik on 30.03.2024.
//

import Foundation
import FirebaseAuth
import Combine

class RegistrationViewModel {
    @Published var isSuccessfulRegistered = false
    @Published var errorStringFormatted: String = ""
    private var email: String = ""
    private var password: String = ""
    private var authService = AuthService.shared
    private var validationService = ValidationService()
    private var cancellables = Set<AnyCancellable>()

    func signUpUser(
        _ email: String?,
        _ password: String?,
        _ passwordConfirmation: String?
    ) {
        guard let email = email,
            let password = password,
            let passwordConfirmation = passwordConfirmation
        else { return }
        self.email = email
        self.password = password

        errorStringFormatted = ""
        let errors = validationService.validateUserData(email, password, passwordConfirmation)

        if errors.isEmpty {
            authService.signUp(email: email, password: password) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success:
                    DispatchQueue.main.async {
                        self.isSuccessfulRegistered = true
                    }
                case .failure(let error):
                    print(error)
                    DispatchQueue.main.async {
                        self.errorStringFormatted = error.localizedDescription
                        self.isSuccessfulRegistered = false
                    }
                }
            }
        } else {
            formatErrors(errors)
        }
    }

    private func formatErrors(_ errors: [String]) {
        errors.forEach { error in
            errorStringFormatted += "\(error)\n"
            print(error)
        }
    }
}
