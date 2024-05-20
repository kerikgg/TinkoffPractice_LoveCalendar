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
    @Published var userModel: UserModel

    init(firestoreService: FirestoreServiceProtocol, storageService: StorageServiceProtocol) {
        self.firestoreService = firestoreService
        self.storageService = storageService
        self.userModel = UserModel(id: "", name: "", email: "")
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
        firestoreService.getUserData(userId: currentUser.uid) { result in
            switch result {
            case .success(let user):
                self.userModel.email = user.email
                self.userModel.name = user.name
                self.userModel.id = user.id
                self.getAvatar()

            case .failure(let error):
                print(error)
                return
            }
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

    private func getAvatar() {
        guard let currentUser = authService.currentUser else { return }
        storageService.getAvatar(userId: currentUser.uid) { result in
            switch result {
            case .success(let data):
                self.userModel.avatarData = data
            case .failure(let error):
                print(error)
            }
        }
    }
}
