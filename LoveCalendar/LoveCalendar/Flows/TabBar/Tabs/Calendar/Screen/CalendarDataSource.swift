//
//  CalendarDataSource.swift
//  LoveCalendar
//
//  Created by kerik on 28.05.2024.
//

import Foundation
import FSCalendar

final class CalendarDataSource: NSObject, FSCalendarDataSource {
    private let viewModel: CalendarViewModel

    init(viewModel: CalendarViewModel) {
        self.viewModel = viewModel
    }

    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        return viewModel.events.filter { Calendar.current.isDate($0.date, inSameDayAs: date) }.count
    }
}
