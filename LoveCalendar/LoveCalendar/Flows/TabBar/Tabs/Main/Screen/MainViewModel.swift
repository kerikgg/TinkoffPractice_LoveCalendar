//
//  MainViewModel.swift
//  LoveCalendar
//
//  Created by kerik on 30.05.2024.
//

import UIKit

final class MainViewModel {
    private var coreDataService: CoreDataServiceProtocol
    @Published var counter: CounterModel?
    @Published var hasCounter: Bool
    @Published var userName: String

    init(coreDataService: CoreDataServiceProtocol) {
        self.coreDataService = coreDataService
        self.counter = nil
        self.hasCounter = false
        self.userName = ""
    }

    func loadCounter() {
        do {
            guard let user = try coreDataService.getCachedUser() else { return }
            userName = user.name
            switch try coreDataService.getCounter(userId: user.id) {
            case .success(let counter):
                self.counter = counter
                self.hasCounter = true
            case .failure(let error):
                print("Failed to fetch counter: \(error)")
                self.hasCounter = false
            }
        } catch {
            print(error.localizedDescription)
        }
    }

    func delete() {
        coreDataService.clearCachedCounterData()
        loadCounter()
    }

    func daysSinceStart() -> Int? {
        guard let startDate = counter?.startDate else { return nil }
        let currentDate = Date()
        return Calendar.current.dateComponents([.day], from: startDate, to: currentDate).day
    }

    func weeksSinceStart() -> Int? {
        guard let startDate = counter?.startDate else { return nil }
        let currentDate = Date()
        return Calendar.current.dateComponents([.weekOfYear], from: startDate, to: currentDate).weekOfYear
    }

    func monthsSinceStart() -> Int? {
        guard let startDate = counter?.startDate else { return nil }
        let currentDate = Date()
        return Calendar.current.dateComponents([.month], from: startDate, to: currentDate).month
    }

    func yearsSinceStart() -> Int? {
        guard let startDate = counter?.startDate else { return nil }
        let currentDate = Date()
        return Calendar.current.dateComponents([.year], from: startDate, to: currentDate).year
    }

    func daysUntilNextAnniversary() -> Int? {
        guard let startDate = counter?.startDate else { return nil }
        let calendar = Calendar.current
        let now = Date()

        var anniversaryDateComponents = calendar.dateComponents([.day, .month], from: startDate)
        anniversaryDateComponents.year = calendar.component(.year, from: now)

        guard let anniversaryDate = calendar.date(from: anniversaryDateComponents) else {
            return nil
        }

        if now > anniversaryDate {
            guard let nextAnniversaryDate = calendar.date(byAdding: .year, value: 1, to: anniversaryDate) else {
                return nil
            }
            return calendar.dateComponents([.day], from: now, to: nextAnniversaryDate).day
        } else {
            return calendar.dateComponents([.day], from: now, to: anniversaryDate).day
        }
    }
}
