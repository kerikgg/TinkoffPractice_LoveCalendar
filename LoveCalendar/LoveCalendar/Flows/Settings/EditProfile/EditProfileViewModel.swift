//
//  EditProfileViewModel.swift
//  LoveCalendar
//
//  Created by kerik on 24.05.2024.
//

import Foundation

final class EditProfileViewModel {
    private var authService = AuthService.shared
    private let firestoreService: FirestoreServiceProtocol
    private let storageService: StorageServiceProtocol
    private let coreDataService: CoreDataServiceProtocol
    private var occuredErrorWhileUpdatingData: Bool
    @Published var isSuccessfulDataSave: Bool
    @Published var userModel: UserModel

    init(
        firestoreService: FirestoreServiceProtocol,
        storageService: StorageServiceProtocol,
        coreDataService: CoreDataServiceProtocol
    ) {
        self.firestoreService = firestoreService
        self.storageService = storageService
        self.coreDataService = coreDataService
        isSuccessfulDataSave = false
        userModel = UserModel(id: "", name: "", email: "", avatarData: nil)
        occuredErrorWhileUpdatingData = false
    }

    func getUserData() {
        do {
            guard let user = try coreDataService.getCachedUser() else { return }
            userModel = user
        } catch {
            print(error.localizedDescription)
        }
    }

    func getUserModel() -> UserModel? {
        do {
            let userModel = try coreDataService.getCachedUser()
            return userModel
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }

    func updateData(imageData: Data?, name: String) {
        guard let imageData else {
            isSuccessfulDataSave = false
            return
        }
        guard let user = authService.currentUser else { return }

        updateUserData(userId: user.uid, name: name)
        updateImageData(userId: user.uid, imageData: imageData)

        if occuredErrorWhileUpdatingData {
            isSuccessfulDataSave = false
        } else {
            coreDataService.updateUserData(user: UserModel(
                id: user.uid,
                name: name,
                email: user.email ?? "",
                avatarData: imageData)
            )
            isSuccessfulDataSave = true
        }
    }

    private func updateImageData(userId: String, imageData: Data) {
        storageService.updateAvatarData(userId: userId, imageData: imageData) { [weak self] error in
            guard let self else { return }
            guard error != nil else { return }
            occuredErrorWhileUpdatingData = true
        }
    }

    private func updateUserData(userId: String, name: String) {
        firestoreService.updateUserData(userId: userId, name: name) { [weak self] error in
            guard let self else { return }
            guard error != nil else { return }
            occuredErrorWhileUpdatingData = true
        }
    }
}
