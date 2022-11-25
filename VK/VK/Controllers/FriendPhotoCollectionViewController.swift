// FriendPhotoCollectionViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

// Экран фото друга
final class FriendPhotoCollectionViewController: UICollectionViewController {
    // MARK: - Private Constants

    private enum Constants {
        static let segueIdentifier = "photosSegue"
        static let photosCellIdentifier = "PhotoCell"
        static let emptyString = ""
    }

    // MARK: - Private Properties

    private var currentIndex = 0
    private var photoName = Constants.emptyString
    private var likeCount = 0
    private var isLiked = false
    private var photoNames: [String] = []
    private let networkService = NetworkService()
    private var friendID = 0 {
        didSet {
            fetchFriends()
        }
    }

    // MARK: - Public Methods

    func configureData(_ photoUrlName: String, _ id: Int) {
        photoName = photoUrlName
        friendID = id
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == Constants.segueIdentifier,
              let vc = segue.destination as? FriendPhotosViewController else { return }
        vc.configure(photoNames)
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
        cell.configure(photoNames, likeCount, false)
        return cell
    }

    // MARK: - Private Methods

    private func fetchFriends() {
        networkService.fetchPhotos(friendID) { [weak self] photos, likes in
            guard let self = self else { return }
            self.photoNames = photos
            self.likeCount = likes
            self.collectionView.reloadData()
        }
    }
}
