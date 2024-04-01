//
//  SignInViewController.swift
//  LoveCalendar
//
//  Created by kerik on 01.04.2024.
//

import UIKit
import SnapKit

class SignInViewController: UIViewController, FlowController {
    var completionHandler: (() -> Void)?
    private let viewModel: SignInViewModel

    init(viewModel: SignInViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        view.backgroundColor = .white
    }
}
