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
            validationErrors.append(Strings.ValidationErrors.emptyEmail)
        }

        if password.isEmpty {
            validationErrors.append(Strings.ValidationErrors.emptyPassword)
        }

        if !validationErrors.isEmpty {
            return validationErrors
        } else {
            if !isValidEmail(email) {
                validationErrors.append(Strings.ValidationErrors.emailFormatError)
            }

            if !isPasswordHasDigit(password) {
                validationErrors.append(Strings.ValidationErrors.passwordDigitError)
            }

            if !isPasswordHasRequireLength(password) {
                validationErrors.append(Strings.ValidationErrors.passwordLengthError)
            }

            if password != passwordConfirmation {
                validationErrors.append(Strings.ValidationErrors.passwordsDontMatch)
            }

            return validationErrors
        }
    }

    func validateURL(urlString: String?) -> String? {
        guard let urlString = urlString, !urlString.isEmpty else {
            return nil
        }

        if let url = URL(string: urlString), url.scheme != nil {
            return urlString
        }

        let prefixedUrlString = "http://" + urlString

        if let url = URL(string: prefixedUrlString), url.scheme != nil {
            return prefixedUrlString
        }

        return nil
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
