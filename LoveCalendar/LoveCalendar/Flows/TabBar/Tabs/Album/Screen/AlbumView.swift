//
//  AlbumView.swift
//  LoveCalendar
//
//  Created by kerik on 29.05.2024.
//

import UIKit

protocol AlbumCollectionViewDelegate: AnyObject {
    func didSelectEvent(_ event: EventModel)
    func didSelectPhoto(_ photo: PhotoModel)
}

final class AlbumView: UIView {
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.autocorrectionType = .no
        searchBar.autocapitalizationType = .none
        searchBar.searchTextField.textColor = .labelText
        searchBar.searchBarStyle = .minimal
        searchBar.returnKeyType = .search
        searchBar.placeholder = Strings.SearchBar.searchPlaceholder
        searchBar.searchTextField.delegate = self

        return searchBar
    }()

    private lazy var norFoundLabel: UILabel = {
        let label = UILabel()
        label.text = "Ничего не найдено"
        label.textColor = .labelText
        label.font = .systemFont(ofSize: 18)
        label.isHidden = true

        return label
    }()

    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: setFlowLayout())
        collectionView.backgroundColor = .clear
        collectionView.register(
            AlbumCollectionViewCell.self,
            forCellWithReuseIdentifier: AlbumCollectionViewCell.reuseIdentifier
        )

        collectionView.register(
            AlbumCollectionViewHeader.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: AlbumCollectionViewHeader.reuseIdentifier
        )

        return collectionView
    }()

    private var dataSource: AlbumCollectionViewDataSource

    init(frame: CGRect, albumDataSource: AlbumCollectionViewDataSource) {
        self.dataSource = albumDataSource
        super.init(frame: frame)
        backgroundColor = .background
        self.setDataSource(albumDataSource: albumDataSource)
        addSubviews(searchBar, collectionView, norFoundLabel)
        makeConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension AlbumView {
    func setDataSource(albumDataSource: AlbumCollectionViewDataSource) {
        collectionView.dataSource = albumDataSource
        collectionView.delegate = albumDataSource
    }

    func setDelegate(_ delegate: AlbumCollectionViewDelegate) {
        dataSource.delegate = delegate
    }

    func setSearchBarDelegate(_ delegate: UISearchBarDelegate) {
        searchBar.delegate = delegate
    }

    func reloadData() {
        collectionView.reloadData()
    }
}

extension AlbumView {
    private func makeConstraints() {
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview()
        }

        collectionView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp_bottomMargin).offset(10)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(safeAreaLayoutGuide)
        }

        norFoundLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }

    private func setFlowLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 180, height: 180)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.headerReferenceSize = CGSize(width: UIScreen.main.bounds.width, height: 50)
        return layout
    }
}

extension AlbumView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
}

extension AlbumView {
    func setNotFoundLabel(_ flag: Bool) {
        norFoundLabel.isHidden = flag
    }
}
