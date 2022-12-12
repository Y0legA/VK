// PhotoCollectionViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка фото друга
final class PhotoCollectionViewCell: UICollectionViewCell {
    // MARK: - Private Constants

    private enum Constants {
        static let emptyString = ""
    }

    // MARK: - Private IBOutlet

    @IBOutlet private var friendImageView: UIImageView!
    @IBOutlet private var likesControl: LikesControl!

    // MARK: - Private Properties

    let networkService = NetworkService()

    // MARK: - Public Methods

    func configure(forIndex index: Int, forPhoto photoName: String, _ photoCacheService: PhotoCacheService) {
        let indexPath = IndexPath(index: index)
        friendImageView.image = photoCacheService.photo(indexPath, photoName)
    }
}
