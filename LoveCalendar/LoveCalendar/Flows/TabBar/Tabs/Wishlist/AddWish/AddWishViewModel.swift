//
//  AddWishViewModel.swift
//  LoveCalendar
//
//  Created by kerik on 25.05.2024.
//

import Foundation

final class AddWishViewModel {
    private let coreDataService: CoreDataServiceProtocol
    private let validationService = ValidationService()

    init(coreDataService: CoreDataServiceProtocol) {
        self.coreDataService = coreDataService
    }

    func addNewWish(title: String, url: String?) {
        do {
            guard let user = try coreDataService.getCachedUser() else { return }
            let validatedURL = validationService.validateURL(urlString: url)
            let wish = WishListModel(title: title, url: validatedURL, uid: UUID())
            coreDataService.setWish(userId: user.id, wish: wish)
        } catch {
            print(error.localizedDescription)
        }
    }
}
