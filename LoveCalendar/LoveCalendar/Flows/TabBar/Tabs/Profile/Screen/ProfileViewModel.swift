//
//  ProfileViewModel.swift
//  LoveCalendar
//
//  Created by kerik on 23.04.2024.
//

import Foundation

class ProfileViewModel {
    private let authService = AuthService.shared

    func logOut() {
        authService.logOut()
    }
}
