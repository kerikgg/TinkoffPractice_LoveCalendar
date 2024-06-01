//
//  CalendarView.swift
//  LoveCalendar
//
//  Created by kerik on 27.05.2024.
//

import UIKit
import FSCalendar

protocol CalendarViewDelegate: AnyObject {
    func didPickedDate(date: Date)
    func didSwipeToDelete(with model: EventModel)
}

final class CalendarView: UIView {
    private lazy var calendar: FSCalendar = {
        let calendar = FSCalendar()
        calendar.firstWeekday = 2
        calendar.appearance.headerDateFormat = "MMMM"
        calendar.appearance.headerTitleColor = .buttonText
        calendar.appearance.weekdayTextColor = .buttonText
        calendar.appearance.selectionColor = .buttonText
        calendar.appearance.todayColor = .systemGray3
        calendar.appearance.eventDefaultColor = .buttonText

        calendar.delegate = self
        
        return calendar
    }()

    private lazy var tableViewLabel: UILabel = {
        let label = UILabel()
        label.text = Strings.Labels.allEvents
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        label.textColor = .labelText

        return label
    }()

    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.backgroundColor = .clear
        tableView.separatorInset = .zero
        tableView.delegate = self
        tableView.register(CalendarTableViewCell.self, forCellReuseIdentifier: CalendarTableViewCell.reuseIdentifier)

        return tableView
    }()

    weak var delegate: CalendarViewDelegate?

    init(frame: CGRect, calendarDataSource: CalendarDataSource, tableViewDataSource: CalendarTableViewDataSource) {
        super.init(frame: frame)
        backgroundColor = .background
        self.setDataSource(calendarDataSource: calendarDataSource, tableViewDataSource: tableViewDataSource)
        addSubviews(calendar, tableViewLabel, tableView)
        makeConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CalendarView {
    private func makeConstraints() {
        calendar.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().inset(UIScreen.main.bounds.height / 2)
        }

        tableViewLabel.snp.makeConstraints { make in
            make.top.equalTo(calendar.snp_bottomMargin).offset(10)
            make.centerX.equalToSuperview()
        }

        tableView.snp.makeConstraints { make in
            make.top.equalTo(tableViewLabel.snp_bottomMargin).offset(10)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(safeAreaLayoutGuide)
        }
    }

    func setDataSource(calendarDataSource: CalendarDataSource, tableViewDataSource: CalendarTableViewDataSource) {
        calendar.dataSource = calendarDataSource
        tableView.dataSource = tableViewDataSource
    }

    func reloadData() {
        tableView.reloadData()
        calendar.reloadData()
    }
}

extension CalendarView: UITableViewDelegate {
}

extension CalendarView: FSCalendarDelegate {
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        delegate?.didPickedDate(date: date)
    }
}

extension CalendarView {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        70
    }

    func tableView(
        _ tableView: UITableView,
        trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath
    ) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(
            style: .destructive,
            title: Strings.Titles.delete
        ) { [weak self] _, _, completionHandler in
            guard let self = self, let dataSource = tableView.dataSource as? CalendarTableViewDataSource else { return }
            let modelToDelete = dataSource.getModels()[indexPath.row]
            self.delegate?.didSwipeToDelete(with: modelToDelete)
            completionHandler(true)
        }
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        return configuration
    }
}
