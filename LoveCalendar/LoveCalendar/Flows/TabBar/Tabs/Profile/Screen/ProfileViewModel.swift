//
//  ProfileViewModel.swift
//  LoveCalendar
//
//  Created by kerik on 23.04.2024.
//

import Foundation

class ProfileViewModel {
    private let authService = AuthService.shared
    private var firestoreService: FirestoreServiceProtocol
    private var storageService: StorageServiceProtocol
    private var coreDataService: CoreDataServiceProtocol
    private var networkService: NetworkServiceProtocol
    @Published var userModel: UserModel
    @Published var isLoadingData: Bool

    init(
        firestoreService: FirestoreServiceProtocol,
        storageService: StorageServiceProtocol,
        coreDataService: CoreDataServiceProtocol,
        networkService: NetworkServiceProtocol
    ) {
        self.firestoreService = firestoreService
        self.storageService = storageService
        self.coreDataService = coreDataService
        self.networkService = networkService
        self.userModel = UserModel(id: "", name: "", email: "", avatarData: nil)
        self.isLoadingData = false
    }

    func logOut() {
        coreDataService.clearCachedUserData()
        authService.logOut()
    }

    func getUserData() {
        guard let currentUser = authService.currentUser else { return }

        do {
            if let user = try coreDataService.getCachedUser() {
                self.userModel.email = user.email
                self.userModel.name = user.name
                self.userModel.id = user.id
                self.userModel.avatarData = user.avatarData
            } else {
                firestoreService.getUserData(userId: currentUser.uid) { result in
                    switch result {
                    case .success(let user):
                        self.userModel.email = user.email
                        self.userModel.name = user.name
                        self.userModel.id = user.id

                    case .failure(let error):
                        print(error)
                        return
                    }

                    self.storageService.getAvatar(userId: currentUser.uid) { result in
                        switch result {
                        case .success(let data):
                            self.userModel.avatarData = data
                            self.coreDataService.setUser(user: self.userModel)
                        case .failure(let error):
                            self.coreDataService.setUser(user: self.userModel)
                            print(error)
                        }
                    }
                }
            }
        } catch {
            print(error)
        }
    }

    func setUserAvatar(imageData: Data?) {
        guard let imageData else { return }
        guard let currentUser = authService.currentUser else { return }
        storageService.uploadAvatar(userId: currentUser.uid, imageData: imageData) { error in
            if let error {
                print(error)
            }
        }
    }

    func getCachedUserData() -> UserModel? {
        do {
            return try coreDataService.getCachedUser()
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }

    func fetchActivity(completion: @escaping ((ActivityModel?) -> Void)) {
        self.isLoadingData = true
        networkService.fetchRandomActivity { [weak self] result in
            guard let self else { return }
            self.isLoadingData = false
            switch result {
            case .success(let activityResponse):
                networkService.fetchImage(from: activityResponse.imageUrl) { result in
                    switch result {
                    case .success(let data):
                        let activity = ActivityModel(
                            id: activityResponse.id,
                            title: activityResponse.title,
                            description: activityResponse.description,
                            image: data
                        )
                        completion(activity)
                    case .failure(let error):
                        print(error.localizedDescription)
                        completion(nil)
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
                completion(nil)
            }
        }
    }
}
