// PhotoCollectionViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

// Ячейка фото друга
final class PhotoCollectionViewCell: UICollectionViewCell {
    // MARK: - Private IBOutlet

    @IBOutlet private var friendImageView: UIImageView!
    @IBOutlet private var likesControl: LikesControl!

    // MARK: - Private Properties

//    private var friendPhotoNames: [String] = []

    // MARK: - Public Methods

    override func awakeFromNib() {
        super.awakeFromNib()
        // configureUI()
    }

    func configureCell(_ imageName: String, _ photoNames: [String], _ likes: Int, _ islike: Bool) {
        friendImageView.image = UIImage(named: imageName)
//        friendPhotoNames.append(imageName)
//        friendPhotoNames.append(contentsOf: photoNames)
        // print(friendPhotoNames)
        likesControl.configure(likes, islike)
    }

    // MARK: - Private Methods

//    @objc private func tapAction() {
//      let vc = FriendPhotosViewController()
//        vc.configure(friendPhotoNames)
//        performSegue(withIdentifier: Constants.segueIdentifier, sender: self)
//    }
//
//    private func configureUI() {
//        friendImageView.isUserInteractionEnabled = true
//        let recogniser = UIGestureRecognizer()
//        recogniser.addTarget(self, action: #selector(tapAction))
//    }
}
