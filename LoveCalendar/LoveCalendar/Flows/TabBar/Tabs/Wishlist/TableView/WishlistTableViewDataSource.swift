//
//  WishlistTableViewDataSource.swift
//  LoveCalendar
//
//  Created by kerik on 25.05.2024.
//

import UIKit

final class WishlistTableViewDataSource: NSObject, UITableViewDataSource {
    private let viewModel: WishlistViewModel
    
    init(viewModel: WishlistViewModel) {
        self.viewModel = viewModel
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.cellModels.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: WishlistTableViewCell.reuseIdentifier,
            for: indexPath
        ) as? WishlistTableViewCell else {
            return UITableViewCell()
        }
        cell.selectionStyle = .none
        cell.configureCell(cellModel: viewModel.cellModels[indexPath.row])
        return cell
    }
    
    func getModels() -> [WishListModel] {
        return viewModel.cellModels
    }
}
