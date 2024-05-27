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
    private var name: String = ""
    private var authService = AuthService.shared
    private var validationService = ValidationService()
    private var cancellables = Set<AnyCancellable>()
    private var firestoreService: FirestoreServiceProtocol

    init(firestoreService: FirestoreServiceProtocol) {
        self.firestoreService = firestoreService
    }

    func signUpUser(
        _ name: String?,
        _ email: String?,
        _ password: String?,
        _ passwordConfirmation: String?
    ) {
        guard let email = email,
            let password = password,
            let passwordConfirmation = passwordConfirmation,
            let name = name
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
                        self.setUserData(name: name)
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

    private func setUserData(name: String) {
        guard let currentUser = authService.currentUser else { return }
        guard let email = currentUser.email else { return }
        let userModel = UserModel(id: currentUser.uid, name: name, email: email)

        firestoreService.setUserData(user: userModel) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success:
                break
            case .failure(let error):
                self.errorStringFormatted = error.localizedDescription
            }
        }
    }
}
