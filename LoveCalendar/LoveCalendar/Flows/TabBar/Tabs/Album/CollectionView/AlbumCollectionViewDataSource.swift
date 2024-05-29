//
//  AlbumCollectionViewDataSource.swift
//  LoveCalendar
//
//  Created by kerik on 29.05.2024.
//

import UIKit

final class AlbumCollectionViewDataSource: NSObject, UICollectionViewDataSource {
    private let viewModel: AlbumViewModel
    weak var delegate: AlbumCollectionViewDelegate?

    init(viewModel: AlbumViewModel) {
        self.viewModel = viewModel
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.events.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: AlbumCollectionViewCell.reuseIdentifier,
            for: indexPath
        ) as? AlbumCollectionViewCell else { return UICollectionViewCell() }

        let event = viewModel.events[indexPath.item]
        cell.configure(with: event)

        return cell
    }
}

extension AlbumCollectionViewDataSource: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let event = viewModel.events[indexPath.item]
        delegate?.didSelectEvent(event)
    }
}
