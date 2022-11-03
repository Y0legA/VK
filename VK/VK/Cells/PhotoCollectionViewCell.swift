// PhotoCollectionViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

// Ячейка фото друга
final class PhotoCollectionViewCell: UICollectionViewCell {
    // MARK: - Private IBOutlets

    @IBOutlet var friendImageView: UIImageView!

    // MARK: - Public Methods

    func configureCell(_ imageName: String) {
        friendImageView.image = UIImage(named: imageName)
    }
}
