//
//  CalendarTableViewDataSource.swift
//  LoveCalendar
//
//  Created by kerik on 28.05.2024.
//

import UIKit

struct EventSection {
    let title: String
    var events: [EventModel]
}

final class CalendarTableViewDataSource: NSObject, UITableViewDataSource {
    private let viewModel: CalendarViewModel

    init(viewModel: CalendarViewModel) {
        self.viewModel = viewModel
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: CalendarTableViewCell.reuseIdentifier,
            for: indexPath
        ) as? CalendarTableViewCell else {
            return UITableViewCell()
        }
        cell.selectionStyle = .none
        let event = viewModel.events[indexPath.row]
        cell.configureCell(cellModel: event)
        return cell
    }

    func getModels() -> [EventModel] {
        return viewModel.events
    }
}
