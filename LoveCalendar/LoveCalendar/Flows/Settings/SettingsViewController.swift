//
//  SettingsViewController.swift
//  LoveCalendar
//
//  Created by kerik on 21.05.2024.
//

import UIKit

enum SettingsStates {
    case edit, theme, back
}

class SettingsViewController: UIViewController, FlowControllerWithValue {
    var completionHandler: ((SettingsStates) -> Void)?
    private let viewModel: SettingsViewModel
    private var dataSource: SettingsTableViewDataSource
    private let settingsView: SettingsView

    init(viewModel: SettingsViewModel) {
        self.viewModel = viewModel
        self.dataSource = SettingsTableViewDataSource(viewModel: viewModel)
        self.settingsView = SettingsView(frame: .zero, dataSource: dataSource)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = settingsView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Настройки"
        view.backgroundColor = .white
    }
}
