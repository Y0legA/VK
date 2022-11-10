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
//    private let interactiveTransition = InteractiveTransition()

    // MARK: - Public Methods

    func configureData(_ user: User) {
        photoName = user.avatarImageName
        photoNames = user.photoNames
        photoNames.insert(user.avatarImageName, at: 0)
        likes = user.likes
        isLiked = user.isliked
        title = user.userName
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == Constants.segueIdentifier,
              let vc = segue.destination as? FriendPhotosViewController else { return }
        vc.configure(photoNames)
//        navigationController?.delegate = self
        // navigationController?.pushViewController(vc, animated: true)
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
        cell.configureCell(photoName, photoNames, likes, isLiked)
        return cell
    }

//    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        guard let vc = storyboard?
//            .instantiateViewController(withIdentifier: Constants.storyboardIdentifier) as? FriendPhotosViewController
//        else { return }
//        vc.configure(photoNames)
//        navigationController?.delegate = self
//        navigationController?.pushViewController(vc, animated: true)
//    }
}

// MARK: - UINavigationControllerDelegate

// extension FriendPhotoCollectionViewController: UINavigationControllerDelegate {
//    func navigationController(
//        _ navigationController: UINavigationController,
//        animationControllerFor operation: UINavigationController.Operation,
//        from fromVC: UIViewController,
//        to toVC: UIViewController
//    ) -> UIViewControllerAnimatedTransitioning? {
//        if operation == .pop {
//            if navigationController.viewControllers.first != toVC {
//                interactiveTransition.viewController = toVC
//            }
//            return PopAnimator()
//        } else if operation == .push {
//            interactiveTransition.viewController = toVC
//            return PushAnimator()
//        }
//        return nil
//    }
//
//    func navigationController(
//        _ navigationController: UINavigationController,
//        interactionControllerFor animationController: UIViewControllerAnimatedTransitioning
//    ) -> UIViewControllerInteractiveTransitioning? {
//        interactiveTransition.hasStarted ? interactiveTransition : nil
//    }
// }
