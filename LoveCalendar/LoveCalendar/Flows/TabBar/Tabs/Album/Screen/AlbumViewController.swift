//
//  AlbumViewController.swift
//  LoveCalendar
//
//  Created by kerik on 21.04.2024.
//

import UIKit
import Combine

enum AlbumStates {
    case add
}

final class AlbumViewController: UIViewController, FlowControllerWithValue {
    var completionHandler: ((AlbumStates) -> Void)?
    private let albumView: AlbumView
    private let viewModel: AlbumViewModel
    private var albumDataSource: AlbumCollectionViewDataSource
    var cancellables = Set<AnyCancellable>()

    init(viewModel: AlbumViewModel) {
        self.viewModel = viewModel
        self.albumDataSource = AlbumCollectionViewDataSource(viewModel: viewModel)
        self.albumView = AlbumView(frame: .zero, albumDataSource: albumDataSource)
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = albumView
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.loadEvents()
        viewModel.loadPhotos()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setBindings()
        albumView.setDelegate(self)
        albumView.setSearchBarDelegate(self)
        setupNavigationBar()
    }
}

extension AlbumViewController {
    private func setBindings() {
        viewModel.$events
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                guard let self else { return }
                self.albumView.reloadData()
            }
            .store(in: &cancellables)

        viewModel.$photos
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                guard let self else { return }
                self.albumView.reloadData()
            }
            .store(in: &cancellables)
    }
}

extension AlbumViewController {
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
        navigationItem.title = Strings.Titles.album
        let rightBarButtonItem = customRightBarButtonItem()
        navigationItem.rightBarButtonItem = rightBarButtonItem
    }
}

extension AlbumViewController: AlbumCollectionViewDelegate {
    func didSelectEvent(_ event: EventModel) {
        let detailVC = PhotoDetailViewController(displayableItem: event)
        detailVC.modalPresentationStyle = .fullScreen
        present(detailVC, animated: true)
    }

    func didSelectPhoto(_ photo: PhotoModel) {
        let detailVC = PhotoDetailViewController(displayableItem: photo)
        detailVC.modalPresentationStyle = .fullScreen
        detailVC.delegate = self
        present(detailVC, animated: true)
    }
}

extension AlbumViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.filter(with: searchText)
        albumView.reloadData()
        var flag = viewModel.hasEvents || viewModel.hasPhotos
        albumView.setNotFoundLabel(flag)
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}

extension AlbumViewController: PhotoDetailViewControllerDelegate {
    func didDeletePhoto(_ photo: PhotoModel) {
        viewModel.delete(model: photo)
        albumView.reloadData()
    }
}
