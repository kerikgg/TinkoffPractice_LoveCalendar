//
//  ValidationService.swift
//  LoveCalendar
//
//  Created by kerik on 31.03.2024.
//

import Foundation

class ValidationService {
    private var validationErrors: [String] = []

    func validateUserData(_ email: String, _ password: String, _ passwordConfirmation: String) -> [String] {
        validationErrors = []

        if email.isEmpty {
            validationErrors.append("Почта не может быть пустой")
        }

        if password.isEmpty {
            validationErrors.append("Пароль не может быть пустой")
        }

        if !validationErrors.isEmpty {
            return validationErrors
        } else {
            if !isValidEmail(email) {
                validationErrors.append("Почта не удовлетворяет формату")
            }

            if !isPasswordHasDigit(password) {
                validationErrors.append("Пароль должен содержать хотя бы 1 цифру")
            }

            if !isPasswordHasRequireLength(password) {
                validationErrors.append("Длина пароля минимум 8 символов")
            }

            if password != passwordConfirmation {
                validationErrors.append("Пароли не совпадают")
            }

            return validationErrors
        }
    }

    private func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }

    private func isPasswordHasDigit(_ password: String) -> Bool {
        let digitRange = password.rangeOfCharacter(from: .decimalDigits)
        guard digitRange != nil else {
            return false
        }
        return true
    }

    private func isPasswordHasRequireLength(_ password: String) -> Bool {
        return password.count >= 8
    }
}
