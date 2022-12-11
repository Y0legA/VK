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

    @IBOutlet var friendImageView: UIImageView!
    @IBOutlet private var likesControl: LikesControl!

    // MARK: - Private Properties

    let networkService = NetworkService()

    // MARK: - Public Methods

    func configure(_ photoNames: [String]) {
        friendImageView.loadImage(photoNames.first ?? Constants.emptyString, networkService)
    }
}
