//
//  MainViewController.swift
//  LoveCalendar
//
//  Created by kerik on 21.04.2024.
//

import UIKit
import Combine

enum MainStates {
    case add
}

class MainViewController: UIViewController, FlowControllerWithValue {
    var completionHandler: ((MainStates) -> Void)?
    private let mainView = MainView(frame: .zero)
    private let viewModel: MainViewModel
    private var cancellables = Set<AnyCancellable>()
    private var userName = ""
    private let alertFactory = AlertFactory()

    init(viewModel: MainViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = mainView
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        viewModel.loadCounter()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.setDelegate(controller: self)
        mainView.delegate = self
        setupNavigationBar()
        setBindings()
        updateView()
    }
}

extension MainViewController {
    private func setBindings() {
        viewModel.$counter
            .receive(on: DispatchQueue.main)
            .sink { [weak self] counter in
                self?.updateView()
                guard let counter else { return }
                guard let userName = self?.userName else { return }
                guard let names = self?.makeNames(userName: userName, partnerName: counter.partnerName) else { return }

                self?.mainView.configureView(names: names, imageData: counter.image)
            }
            .store(in: &cancellables)

        viewModel.$userName
            .receive(on: DispatchQueue.main)
            .sink { [weak self] name in
                self?.userName = name
            }
            .store(in: &cancellables)

        viewModel.$hasCounter
            .receive(on: DispatchQueue.main)
            .sink { [weak self] hasCounter in
                self?.mainView.displayStartView(flag: hasCounter)
                if !hasCounter {
                    self?.navigationItem.rightBarButtonItem = nil
                } else {
                    let rightBarButton = self?.customRightBarButtonItem()
                    self?.navigationItem.rightBarButtonItem = rightBarButton
                }
            }
            .store(in: &cancellables)
    }
}

extension MainViewController {
    private func customRightBarButtonItem() -> UIBarButtonItem {
        let action = UIAction { [weak self] _ in
            guard let self else { return }
            self.showDeletelert()
        }

        let button = UIBarButtonItem(systemItem: .trash, primaryAction: action)
        button.tintColor = .black

        return button
    }

    private func setupNavigationBar() {
        navigationItem.title = Strings.Titles.main
    }

    private func showDeletelert() {
        let alert = alertFactory.makeDeleteCounterAlert { [weak self] _ in
            guard let self else { return }
            self.viewModel.delete()
        }
        present(alert, animated: true)
    }
}

extension MainViewController: StartViewDelegate {
    func didTapStartButton() {
        self.completionHandler?(.add)
    }
}

extension MainViewController {
    private func makeNames(userName: String, partnerName: String) -> String {
        return userName + " " + Strings.and + " " + partnerName
    }
}

extension MainViewController {
    private func updateView() {
        updateDaysSinceLabel()
        updateWeeksSinceLabel()
        updateMonthsSinceLabel()
        updateYearsSinceLabel()
        updateDaysUntilAnniversaryLabel()
    }

    private func updateDaysSinceLabel() {
        let daysSinceStart = viewModel.daysSinceStart() ?? 0
        mainView.updateDaysSinceLabel(with: Strings.daysSince(daysSinceStart.days()))
    }

    private func updateWeeksSinceLabel() {
        let weeksSinceStart = viewModel.weeksSinceStart() ?? 0
        mainView.updateWeeksSinceLabel(with: Strings.together + " " + weeksSinceStart.weeks())
    }

    private func updateMonthsSinceLabel() {
        let monthsSinceStart = viewModel.monthsSinceStart() ?? 0
        mainView.updateMonthsSinceLabel(with: Strings.together + " " + monthsSinceStart.months())
    }

    private func updateYearsSinceLabel() {
        let yearsSinceStart = viewModel.yearsSinceStart() ?? 0
        mainView.updateYearsSinceLabel(with: Strings.together + " " + yearsSinceStart.years())
    }

    private func updateDaysUntilAnniversaryLabel() {
        let daysUntilAnniversary = viewModel.daysUntilNextAnniversary() ?? 0
        mainView.updateDaysUntilAnniversaryLabel(with: Strings.daysUntilAnniversary(daysUntilAnniversary.days()))
    }
}

extension MainViewController: MainViewDelegate {
    func didTapDaysSinceLabel() {
        if mainView.areAdditionalLabelsVisible {
            mainView.updateWeeksSinceLabel(with: "")
            mainView.updateMonthsSinceLabel(with: "")
            mainView.updateYearsSinceLabel(with: "")
        } else {
            updateWeeksSinceLabel()
            updateMonthsSinceLabel()
            updateYearsSinceLabel()
        }
        mainView.toggleAdditionalLabels()
    }
}
