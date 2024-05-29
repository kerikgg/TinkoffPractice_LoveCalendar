//
//  AlbumViewController.swift
//  LoveCalendar
//
//  Created by kerik on 21.04.2024.
//

import UIKit
import Combine

enum AlbumStates {
    case add, detail(_ event: EventModel)
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
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setBindings()
        albumView.setDelegate(self)
        albumView.setSearchBarDelegate(self)
        navigationItem.title = Strings.Titles.album
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
    }
}

extension AlbumViewController: AlbumCollectionViewDelegate {
    func didSelectEvent(_ event: EventModel) {
        self.completionHandler?(.detail(event))
    }
}

extension AlbumViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.filterEvents(with: searchText)
        albumView.reloadData()
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}
