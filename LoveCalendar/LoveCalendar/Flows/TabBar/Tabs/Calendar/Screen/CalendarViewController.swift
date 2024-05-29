//
//  CalendarViewController.swift
//  LoveCalendar
//
//  Created by kerik on 21.04.2024.
//

import UIKit
import Combine

enum CalendarStates {
    case add(Date)
}

final class CalendarViewController: UIViewController, FlowControllerWithValue {
    var completionHandler: ((CalendarStates) -> Void)?
    private let alertFactory = AlertFactory()
    private let calendarView: CalendarView
    private let viewModel: CalendarViewModel
    private var calendarDataSource: CalendarDataSource
    private var tableViewDataSource: CalendarTableViewDataSource
    var cancellables = Set<AnyCancellable>()
    var pickedDate: Date?

    init(viewModel: CalendarViewModel) {
        self.viewModel = viewModel
        self.calendarDataSource = CalendarDataSource(viewModel: viewModel)
        self.tableViewDataSource = CalendarTableViewDataSource(viewModel: viewModel)
        self.calendarView = CalendarView(
            frame: .zero,
            calendarDataSource: calendarDataSource,
            tableViewDataSource: tableViewDataSource
        )
        self.pickedDate = nil
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = calendarView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.loadEvents()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.calendarView.delegate = self
        setupNavigationBar()
        setBindings()
    }
}

extension CalendarViewController {
    private func customRightBarButtonItem() -> UIBarButtonItem {
        let action = UIAction { [weak self] _ in
            guard let self else { return }
            if let pickedDate = self.pickedDate {
                self.completionHandler?(.add(pickedDate))
            } else {
                let alert = alertFactory.makeErrorAlert(message: Strings.Alerts.Messages.date)
                present(alert, animated: true)
            }
        }

        let button = UIBarButtonItem(systemItem: .add, primaryAction: action)
        button.tintColor = .buttonText

        return button
    }

    private func setupNavigationBar() {
        navigationItem.title = Strings.Titles.calendar
        let rightBarButtonItem = customRightBarButtonItem()
        navigationItem.rightBarButtonItem = rightBarButtonItem
    }
}

extension CalendarViewController: CalendarViewDelegate {
    func didSwipeToDelete(with model: EventModel) {
        viewModel.delete(model: model)
    }
    
    func didPickedDate(date: Date) {
        pickedDate = date
    }
}

extension CalendarViewController {
    private func setBindings() {
        viewModel.$events
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                guard let self else { return }
                self.calendarView.reloadData()
            }
            .store(in: &cancellables)
    }
}
