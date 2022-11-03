// FriendPhotoCollectionViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

// Экран фото друга
final class FriendPhotoCollectionViewController: UICollectionViewController {
    // MARK: - Private Constants

    private enum Constants {
        static let photosCellIdentifier = "PhotoCell"
    }

    // MARK: - Private Properties

    private var photoName = String()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Public Methods

    func configureData(_ friend: User) {
        photoName = friend.avatarImageName
        title = friend.userName
    }

    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        1
    }

    override func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: Constants.photosCellIdentifier,
            for: indexPath
        ) as? PhotoCollectionViewCell else { return PhotoCollectionViewCell() }
        cell.configureCell(photoName)
        return cell
    }
}
