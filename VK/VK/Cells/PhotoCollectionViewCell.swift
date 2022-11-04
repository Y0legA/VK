// PhotoCollectionViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

// Ячейка фото друга
final class PhotoCollectionViewCell: UICollectionViewCell {
    // MARK: - Private IBOutlet

    @IBOutlet private var friendImageView: UIImageView!
    @IBOutlet private var likesControl: LikesControl!

    // MARK: - Public Methods

    func configureCell(_ imageName: String, _ likes: Int, _ islike: Bool) {
        friendImageView.image = UIImage(named: imageName)
        print(imageName)
        likesControl.configure(likes, islike)
    }
}
