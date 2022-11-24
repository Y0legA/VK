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
    private var likes = 0
    private var isLiked = false
    private var photoNames: [String] = []
    private let networkService = NetworkService()
    private var friendID = 0 {
        didSet {
            networkService.fetchPhotos(friendID) { photos, likes in
                self.photoNames = photos
                self.likes = likes
                self.collectionView.reloadData()
            }
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
        cell.configure(photoNames, likes, false)
        return cell
    }
}
