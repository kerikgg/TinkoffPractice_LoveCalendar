//
//  SignInViewController.swift
//  LoveCalendar
//
//  Created by kerik on 01.04.2024.
//

import UIKit
import SnapKit
import Combine

enum SignInState {
    case login, back
}

class SignInViewController: UIViewController, FlowControllerWithValue {
    var completionHandler: ((SignInState) -> Void)?
    private let signInView = SignInView(frame: .zero)
    private let viewModel: SignInViewModel
    private let alertFactory = AlertFactory()
    var cancellables = Set<AnyCancellable>()

    init(viewModel: SignInViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = signInView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        signInView.delegate = self
        setBindings()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if self.isMovingFromParent {
            completionHandler?(.back)
        }
    }
}

extension SignInViewController {
    private func setBindings() {
        viewModel.$validationError
            .receive(on: DispatchQueue.main)
            .sink { [weak self] validationError in
                guard let self = self else { return }
                self.signInView.setErrors(validationError)
            }
            .store(in: &cancellables)

        viewModel.$isSuccessfullyLoggedIn
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isSuccessfullyLoggedIn in
                if isSuccessfullyLoggedIn {
                    guard let self else { return }
                    self.completionHandler?(.login)
                }
            }
            .store(in: &cancellables)

        viewModel.$firebaseError
            .receive(on: DispatchQueue.main)
            .dropFirst(1)
            .sink { [weak self] firebaseError in
                guard let self = self else { return }
                let alert = alertFactory.makeErrorAlert(message: firebaseError)
                self.present(alert, animated: true)
            }
            .store(in: &cancellables)
    }
}

extension SignInViewController: SignViewDelegate {
    func didPressSignInButton(_ email: String?, _ password: String?) {
        self.viewModel.signInUser(email: email, password: password)
    }
}
