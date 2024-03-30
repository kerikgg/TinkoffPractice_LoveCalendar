//
//  ModuleFactoryProtocol.swift
//  LoveCalendar
//
//  Created by kerik on 29.03.2024.
//

import Foundation

protocol ModuleFactoryProtocol {
    func makeAuthModule() -> AuthViewController

    func makeRegistrationModule(viewModel: RegistrationViewModel) -> RegistrationViewController
}
