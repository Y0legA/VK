// PhotoCollectionViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

// Ячейка фото друга
final class PhotoCollectionViewCell: UICollectionViewCell {
    // MARK: - Private IBOutlet

    @IBOutlet private var friendImageView: UIImageView!
    @IBOutlet private var likesControl: LikesControl!

    // MARK: - Public Methods

    func configure(_ imageName: String, _ photoNames: [String], _ likes: Int, _ islike: Bool) {
        friendImageView.image = UIImage(named: imageName)
        likesControl.configure(likes, islike)
    }
}
