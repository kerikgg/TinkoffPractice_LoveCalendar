//
//  WishlistViewController.swift
//  LoveCalendar
//
//  Created by kerik on 21.04.2024.
//

import UIKit
import Combine

enum WishlistStates {
    case add
}

final class WishlistViewController: UIViewController, FlowControllerWithValue {
    var completionHandler: ((WishlistStates) -> Void)?
    private let wishlistView: WishlistView
    private let viewModel: WishlistViewModel
    private var dataSource: WishlistTableViewDataSource
    var cancellables = Set<AnyCancellable>()

    init(viewModel: WishlistViewModel) {
        self.viewModel = viewModel
        self.dataSource = WishlistTableViewDataSource(viewModel: viewModel)
        self.wishlistView = WishlistView(frame: .zero, dataSource: dataSource)
        super.init(nibName: nil, bundle: nil)
        viewModel.getWishlist()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = wishlistView
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.getWishlist()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.wishlistView.delegate = self
        setBindings()
        setupNavigationBar()
    }
}

extension WishlistViewController {
    private func customRightBarButtonItem() -> UIBarButtonItem {
        let action = UIAction { [weak self] _ in
            guard let self else { return }
            self.completionHandler?(.add)
        }

        let button = UIBarButtonItem(systemItem: .add, primaryAction: action)
        button.tintColor = .buttonText

        return button
    }

    private func setupNavigationBar() {
        navigationItem.title = Strings.Titles.wishlist
        let rightBarButtonItem = customRightBarButtonItem()
        navigationItem.rightBarButtonItem = rightBarButtonItem
    }
}

extension WishlistViewController: WishlistViewDelegate {
    func didTapCell(with model: WishListModel) {
        let urlString = model.url ?? ""

        let item = urlString.isEmpty ? model.title : model.title + "\n" + urlString

        let items: [Any] = [item]
        let activityViewControler = UIActivityViewController(activityItems: items, applicationActivities: nil)
        self.present(activityViewControler, animated: true)
    }

    func didSwipeToDelete(with model: WishListModel) {
        viewModel.deleteWish(model: model)
    }
}

extension WishlistViewController {
    private func setBindings() {
        viewModel.$cellModels
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                guard let self else { return }
                self.wishlistView.reloadData()
            }
            .store(in: &cancellables)
    }
}
