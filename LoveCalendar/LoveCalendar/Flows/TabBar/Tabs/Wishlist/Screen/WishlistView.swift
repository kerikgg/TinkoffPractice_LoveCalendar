//
//  WhishlistView.swift
//  LoveCalendar
//
//  Created by kerik on 25.05.2024.
//

import UIKit

protocol WishlistViewDelegate: AnyObject {
    func didTapCell(with model: WishlistCellModel)
    func didSwipeToDelete(with model: WishlistCellModel)
}

final class WishlistView: UIView {
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.backgroundColor = .clear
        tableView.separatorInset = .zero
        tableView.delegate = self
        tableView.register(
            WishlistTableViewCell.self,
            forCellReuseIdentifier: WishlistTableViewCell.reuseIdentifier)

        return tableView
    }()

    weak var delegate: WishlistViewDelegate?

    init(frame: CGRect, dataSource: WishlistTableViewDataSource) {
        super.init(frame: frame)
        self.setDataSource(with: dataSource)
        addSubviews(tableView)
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension WishlistView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let dataSource = tableView.dataSource as? WishlistTableViewDataSource else { return }
        let models = dataSource.getModels()
        delegate?.didTapCell(with: models[indexPath.row])
    }
}

extension WishlistView {
    func setDataSource(with dataSource: WishlistTableViewDataSource) {
        tableView.dataSource = dataSource
    }

    private func makeConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    func reloadData() {
        self.tableView.reloadData()
    }
}

extension WishlistView {
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(
        _ tableView: UITableView,
        trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath
    ) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(
            style: .destructive,
            title: Strings.Titles.delete
        ) { [weak self] _, _, completionHandler in
            guard let self = self, let dataSource = tableView.dataSource as? WishlistTableViewDataSource else { return }
            let modelToDelete = dataSource.getModels()[indexPath.row]
            self.delegate?.didSwipeToDelete(with: modelToDelete)
            completionHandler(true)
        }
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        return configuration
    }
}
