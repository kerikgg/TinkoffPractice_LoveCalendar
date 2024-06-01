//
//  AddCounterViewModel.swift
//  LoveCalendar
//
//  Created by kerik on 31.05.2024.
//

import Foundation

final class AddCounterViewModel {
    private let coreDataService: CoreDataServiceProtocol

    init(coreDataService: CoreDataServiceProtocol) {
        self.coreDataService = coreDataService
    }

    func addNewCounter(counter: CounterModel) {
        do {
            guard let user = try coreDataService.getCachedUser() else { return }
            coreDataService.setCounter(userId: user.id, counter: counter)
        } catch {
            print(error.localizedDescription)
        }
    }
}
