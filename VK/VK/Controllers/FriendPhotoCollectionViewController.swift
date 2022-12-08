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

    private let networkService = NetworkService()
    private var currentIndex = 0
    private var photoName = Constants.emptyString
    private var likeCount = 0
    private var isLiked = false
    private var photoNames: [String] = []

    private var friendID = 0 {
        didSet {
            loadPhotos()
        }
    }

    private var friendPhotos: [FriendPhoto] = []

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
        cell.configure(photoNames, networkService)
        return cell
    }

    func configureData(_ photoUrlName: String, _ id: Int) {
        photoName = photoUrlName
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
            let realm = try Realm()
            let photos = Array(realm.objects(FriendPhoto.self))
            photoName = photoNames.first ?? Constants.emptyString
            let photoNamesID = photos.map(\.ownerID)
            friendPhotos = photos
            if photoNamesID.contains(where: { tempId in
                friendID == tempId
            }) {
                friendPhotos = photos.filter {
                    $0.ownerID == friendID
                }
                let friendsDetailArray = photos.map(\.photos.last)
                photoNames = friendsDetailArray.map { $0?.url ?? Constants.emptyString }
            } else {
                fetchFriends()
            }
        } catch {
            showAlert(
                title: Constants.emptyString,
                message: error.localizedDescription,
                actionTitle: Constants.ok,
                handler: nil
            )
        }
    }
}
