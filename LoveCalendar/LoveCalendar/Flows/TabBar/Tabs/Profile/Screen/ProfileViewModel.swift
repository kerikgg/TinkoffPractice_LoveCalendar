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
    @Published var userModel: UserModel

    init(
        firestoreService: FirestoreServiceProtocol,
        storageService: StorageServiceProtocol,
        coreDataService: CoreDataServiceProtocol
    ) {
        self.firestoreService = firestoreService
        self.storageService = storageService
        self.coreDataService = coreDataService
        self.userModel = UserModel(id: "", name: "", email: "", avatarData: nil)
    }

    func logOut() {
        authService.logOut()
    }

//    func getUserData(completion: @escaping (Result<UserModel, Error>) -> Void) {
//        guard let currentUser = authService.currentUser else { return }
//        firestoreService.getUserData(userId: currentUser.uid) { result in
//            switch result {
//            case .success(let user):
//                self.getAvatar()
//
//                self.userModel.email = user.email
//                self.userModel.name = user.name
//                self.userModel.id = user.id
//
//                completion(.success(self.userModel))
//            case .failure(let error):
//                print(error)
//                completion(.failure(error))
//                return
//            }
//        }
//    }

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
}
