//
//  MainViewModel.swift
//  LoveCalendar
//
//  Created by kerik on 30.05.2024.
//

import UIKit

final class MainViewModel {
    private var coreDataService: CoreDataServiceProtocol
    private var firestoreService: FirestoreServiceProtocol
    private var storageService: StorageServiceProtocol
    @Published var counter: CounterModel?
    @Published var hasCounter: Bool
    @Published var userName: String

    init(
        coreDataService: CoreDataServiceProtocol,
        firestoreService: FirestoreServiceProtocol,
        storageService: StorageServiceProtocol
    ) {
        self.coreDataService = coreDataService
        self.firestoreService = firestoreService
        self.storageService = storageService
        self.counter = nil
        self.hasCounter = false
        self.userName = ""
    }

    func loadCounter() {
        do {
            if let user = try coreDataService.getCachedUser() {
                handleUser(user: user)
            } else {
                fetchUserDataFromNetwork()
            }
        } catch {
            print(error.localizedDescription)
        }
    }

    private func fetchUserDataFromNetwork() {
        guard let currentUser = AuthService.shared.currentUser else { return }

        firestoreService.getUserData(userId: currentUser.uid) { result in
            switch result {
            case .success(let user):
                self.handleUser(user: user)
                self.fetchUserAvatar(user: user, userId: currentUser.uid)
            case .failure(let error):
                print("Failed to fetch user data: \(error)")
            }
        }
    }

    private func fetchUserAvatar(user: UserModel, userId: String) {
        storageService.getAvatar(userId: userId) { result in
            switch result {
            case .success(let data):
                var updatedUser = user
                updatedUser.avatarData = data
                self.coreDataService.setUser(user: updatedUser)
            case .failure(let error):
                print("Failed to fetch avatar: \(error)")
                // Cache user without avatar data
                self.coreDataService.setUser(user: user)
            }
        }
    }

    private func handleUser(user: UserModel) {
        self.userName = user.name
        switch try? coreDataService.getCounter(userId: user.id) {
        case .success(let counter):
            self.counter = counter
            self.hasCounter = true
        case .failure(let error):
            print("Failed to fetch counter: \(error)")
            self.hasCounter = false
        case .none:
            self.hasCounter = false
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
