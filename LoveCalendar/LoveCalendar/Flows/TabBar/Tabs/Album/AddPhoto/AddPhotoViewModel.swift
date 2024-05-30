//
//  AddPhotoViewModel.swift
//  LoveCalendar
//
//  Created by kerik on 30.05.2024.
//

import Foundation

final class AddPhotoViewModel {
    private let coreDataService: CoreDataServiceProtocol

    init(coreDataService: CoreDataServiceProtocol) {
        self.coreDataService = coreDataService
    }

    func addNewPhoto(photo: PhotoModel) {
        do {
            guard let user = try coreDataService.getCachedUser() else { return }
            coreDataService.setPhoto(userId: user.id, photo: photo)
        } catch {
            print(error.localizedDescription)
        }
    }
}
