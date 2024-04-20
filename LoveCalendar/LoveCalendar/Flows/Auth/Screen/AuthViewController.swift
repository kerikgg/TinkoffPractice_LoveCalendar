//
//  ViewController.swift
//  LoveCalendar
//
//  Created by kerik on 26.03.2024.
//

import UIKit
import SnapKit

enum AuthStates {
    case signIn
    case signUp
}

class AuthViewController: UIViewController, FlowControllerWithValue {
    private let authView = AuthView(frame: .zero)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        authView.delegate = self
    }

    override func loadView() {
        view = authView
    }

    var completionHandler: ((AuthStates) -> Void)?
}

extension AuthViewController: AuthViewDelegate {
    func didPressSignIn() {
        self.completionHandler?(.signIn)
    }

    func didPressSignUp() {
        self.completionHandler?(.signUp)
    }
}
