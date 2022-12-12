// FriendPhotoCollectionViewController.swift
// Copyright © RoadMap. All rights reserved.

import RealmSwift
import UIKit

/// Экран фото друга
final class FriendPhotoCollectionViewController: UICollectionViewController {
    // MARK: - Private Constants

    private enum Constants {
        static let segueIdentifier = "photosSegue"
        static let photosCellIdentifier = "PhotoCell"
        static let emptyString = ""
        static let ok = "OK"
    }

    // MARK: - Private Properties

    private lazy var photoCacheService = PhotoCacheService(__: self.collectionView)
    private let networkService = NetworkService()
    private var currentIndex = 0
    private var photoName = Constants.emptyString
    private var likeCount = 0
    private var isLiked = false
    private var photoNames: [String] = []
    private var friendPhotos: [FriendPhoto] = []

    private var friendID = 0 {
        didSet {
            loadPhotos()
        }
    }

    // MARK: - Public Methods

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
        cell.configure(forPhoto: photoNames.first ?? Constants.emptyString, photoCacheService)
        return cell
    }

    func configureData(_ id: Int) {
        friendID = id
    }

    // MARK: - Private Methods

    private func fetchFriends() {
        networkService.fetchPhotos(friendID) { [weak self] photo in
            guard let self = self else { return }
            switch photo {
            case let .success(data):
                let friendsDetail = data.friendDetail.friendPhotos.map(\.photos.last)
                self.photoNames = friendsDetail.map { $0?.url ?? Constants.emptyString }
                RealmService.saveData(data.friendDetail.friendPhotos)
                self.collectionView.reloadData()
            case let .failure(error):
                self.showAlert(
                    title: Constants.emptyString,
                    message: error.localizedDescription,
                    actionTitle: Constants.ok,
                    handler: nil
                )
            }
        }
    }

    private func loadPhotos() {
        do {
            guard let photos = RealmService.loadData(FriendPhoto.self) else { return }
            photoName = photoNames.first ?? Constants.emptyString
            let photoNamesID = photos.map(\.ownerID)
            friendPhotos = Array(photos)
            if photoNamesID.contains(where: { tempId in
                friendID == tempId
            }) {
                friendPhotos = photos.filter {
                    $0.ownerID == friendID
                }
                let friendsDetailArray = friendPhotos.map(\.photos.last)
                photoNames = friendsDetailArray.map { $0?.url ?? Constants.emptyString }
            } else {
                fetchFriends()
            }
        }
    }
}
