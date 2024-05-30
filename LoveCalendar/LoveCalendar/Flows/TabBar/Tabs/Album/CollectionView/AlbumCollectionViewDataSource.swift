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

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        viewModel.numberOfSections
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if viewModel.hasEvents && section == 0 {
            return viewModel.events.count
        } else if viewModel.hasPhotos && (viewModel.hasEvents ? section == 1 : section == 0) {
            return viewModel.photos.count
        }
        return 0
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: AlbumCollectionViewCell.reuseIdentifier,
            for: indexPath
        ) as? AlbumCollectionViewCell else { return UICollectionViewCell() }

        if viewModel.hasEvents && indexPath.section == 0 {
            let event = viewModel.events[indexPath.item]
            cell.configure(with: event)
        } else if viewModel.hasPhotos && (viewModel.hasEvents ? indexPath.section == 1 : indexPath.section == 0) {
            let photo = viewModel.photos[indexPath.item]
            cell.configure(with: photo)
        }

        return cell
    }
}

extension AlbumCollectionViewDataSource: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if viewModel.hasEvents && indexPath.section == 0 {
            let event = viewModel.events[indexPath.item]
            delegate?.didSelectEvent(event)
        } else if viewModel.hasPhotos && (viewModel.hasEvents ? indexPath.section == 1 : indexPath.section == 0) {
            let photo = viewModel.photos[indexPath.item]
            delegate?.didSelectPhoto(photo)
        }
    }

    func collectionView(
        _ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        at indexPath: IndexPath
    ) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: AlbumCollectionViewHeader.reuseIdentifier,
            for: indexPath
        ) as? AlbumCollectionViewHeader else { return UICollectionReusableView() }

        if viewModel.hasEvents && indexPath.section == 0 {
            header.titleLabel.text = Strings.Sections.events
        } else if viewModel.hasPhotos && (viewModel.hasEvents ? indexPath.section == 1 : indexPath.section == 0) {
            header.titleLabel.text = Strings.Sections.photos
        }

        return header
    }
}
