// FriendPhotosViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

// Фото друга
final class FriendPhotosViewController: UIViewController {
    // Private Constants
    enum Constants {
        static let emptyString = ""
        static let opacity = "opacity"
    }

    // MARK: - Private IBoutlet

    @IBOutlet private var imageView: UIImageView!

    // MARK: - Private Properties

    private lazy var firstPhotoName = friendPhotoNames.first
    private lazy var lastPhotoName = friendPhotoNames.last

    private var friendPhotoNames: [String] = []
    private var currentPhoto = Constants.emptyString
    private var prevousIndex = 0
    private var currentPhotoIndex = 0

    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }

    // MARK: - Public Methods

    func configure(_ photos: [String]) {
        friendPhotoNames = photos
    }

    // MARK: - Private Methods

    @objc private func swipeAction(_ gesture: UISwipeGestureRecognizer) {
        prevousIndex = currentPhotoIndex
        switch gesture.direction {
        case .left:
            guard currentPhoto != lastPhotoName else { fallthrough }
            currentPhotoIndex += 1
            animatePhotoImageView(view.bounds.width)
        case .right:
            guard currentPhoto != firstPhotoName else { fallthrough }
            currentPhotoIndex -= 1
            animatePhotoImageView(-view.bounds.width)
        case .down:
            swipeDown()
        default:
            return
        }
    }

    private func animatePhotoImageView(_ offSet: CGFloat) {
        currentPhoto = friendPhotoNames[currentPhotoIndex]
        UIView.animate(
            withDuration: 0.5,
            animations: {
                self.imageView.image = UIImage(named: self.friendPhotoNames[self.prevousIndex])
                self.imageView.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
                self.animateDisapearPhoto()
            },
            completion: { _ in
                self.imageView.transform = CGAffineTransform(translationX: offSet, y: 0)
                UIView.animate(withDuration: 1.0) {
                    self.imageView.image = UIImage(
                        named: self.friendPhotoNames[self.currentPhotoIndex]
                    )
                    self.imageView.transform = .identity
                }
            }
        )
    }

    private func animateDisapearPhoto() {
        let fadeAnimation = CABasicAnimation(keyPath: Constants.opacity)
        fadeAnimation.fromValue = 1
        fadeAnimation.toValue = 0
        fadeAnimation.duration = 0.5
        imageView.layer.add(fadeAnimation, forKey: nil)
    }

    private func swipeDown() {
        UIView.animate(
            withDuration: 0.7,
            animations: {
                let translation = CGAffineTransform(translationX: 0, y: self.view.bounds.height)
                self.imageView.transform = translation.concatenating(CGAffineTransform(scaleX: 0.3, y: 0.3))
            },
            completion: { _ in
                self.navigationController?.popViewController(animated: true)
            }
        )
    }

    private func configureGesture(_ direction: UISwipeGestureRecognizer.Direction) {
        let gesture = UISwipeGestureRecognizer(target: self, action: #selector(swipeAction))
        gesture.direction = direction
        imageView.addGestureRecognizer(gesture)
    }

    private func configureUI() {
        configureImageView()
        configureGesture(.left)
        configureGesture(.right)
        configureGesture(.down)
    }

    private func configureImageView() {
        imageView.image = UIImage(named: firstPhotoName ?? Constants.emptyString)
        imageView.isUserInteractionEnabled = true
    }
}
