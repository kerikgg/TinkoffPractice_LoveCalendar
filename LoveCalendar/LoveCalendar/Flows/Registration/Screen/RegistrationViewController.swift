//
//  RegistrationViewController.swift
//  LoveCalendar
//
//  Created by kerik on 30.03.2024.
//

import UIKit
import Combine

class RegistrationViewController: UIViewController, FlowController {
    private let registrationView = RegistrationView(frame: .zero)
    var completionHandler: (() -> Void)?
    private let viewModel: RegistrationViewModel
    var cancellables = Set<AnyCancellable>()

    init(viewModel: RegistrationViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = registrationView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        registrationView.delegate = self
        setBindings()
    }
}

extension RegistrationViewController: RegistrationViewDelegate {
    func didPressSignUpButton(_ email: String?, _ password: String?, _ passwordConfirmation: String?) {
        self.viewModel.signUpUser(email, password, passwordConfirmation)
    }
}

extension RegistrationViewController {
    private func setBindings() {
        viewModel.$isSuccessfulRegistered
            .sink { [weak self] isSuccessfulRegistered in
                guard let self = self else { return }
                if isSuccessfulRegistered {
                    self.completionHandler?()
                }
            }
            .store(in: &cancellables)

        viewModel.$errorStringFormatted
            .receive(on: DispatchQueue.main)
            .sink { [weak self] errorStringFormatted in
                guard let self = self else { return }
                self.registrationView.setErrors(errorStringFormatted)
            }
            .store(in: &cancellables)
    }
}
