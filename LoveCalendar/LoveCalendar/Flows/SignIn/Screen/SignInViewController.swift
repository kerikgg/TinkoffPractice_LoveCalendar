//
//  SignInViewController.swift
//  LoveCalendar
//
//  Created by kerik on 01.04.2024.
//

import UIKit
import SnapKit
import Combine

class SignInViewController: UIViewController, FlowController {
    var completionHandler: (() -> Void)?
    private let signInView = SignInView(frame: .zero)
    private let viewModel: SignInViewModel
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
        view.backgroundColor = .white
        signInView.delegate = self
        setBindings()
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
                    self.completionHandler?()
                    print("работает, но дальше переход пока не сделал")
                }
            }
            .store(in: &cancellables)

        viewModel.$firebaseError
            .receive(on: DispatchQueue.main)
            .sink { [weak self] firebaseError in
                guard let self = self else { return }
                self.signInView.setErrors(firebaseError)
            }
            .store(in: &cancellables)
    }
}

extension SignInViewController: SignViewDelegate {
    func didPressSignInButton(_ email: String?, _ password: String?) {
        self.viewModel.signInUser(email: email, password: password)
    }
}
