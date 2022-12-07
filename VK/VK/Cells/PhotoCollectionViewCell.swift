// PhotoCollectionViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

// Ячейка фото друга
final class PhotoCollectionViewCell: UICollectionViewCell {
    // MARK: - Private Constants

    private enum Constants {
        static let emptyString = ""
    }

    // MARK: - Private IBOutlet

    @IBOutlet private var friendImageView: UIImageView!
    @IBOutlet private var likesControl: LikesControl!

    // MARK: - Public Methods

    func configure(_ photoNames: [String], _ networkService: NetworkService) {
        friendImageView.loadImage(photoNames.first ?? Constants.emptyString, networkService)
    }
}
