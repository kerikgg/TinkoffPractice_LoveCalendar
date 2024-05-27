//
//  WhishlistViewModel.swift
//  LoveCalendar
//
//  Created by kerik on 25.05.2024.
//

import Foundation

final class WishlistViewModel {
    private let coreDataService: CoreDataServiceProtocol
    @Published var cellModels: [WishlistCellModel]

    init(coreDataService: CoreDataServiceProtocol) {
        cellModels = []
        self.coreDataService = coreDataService
    }

    func getWishlist() {
        do {
            guard let user = try coreDataService.getCachedUser() else { return }
            let wishes = try coreDataService.getWishes(userId: user.id)
            cellModels = wishes
        } catch {
            print(error.localizedDescription)
        }
    }

    func deleteWish(model: WishlistCellModel) {
        do {
            guard let user = try coreDataService.getCachedUser() else { return }
            coreDataService.deleteWish(userId: user.id, wish: model)
            getWishlist()
        } catch {
            print(error.localizedDescription)
        }
    }
}
