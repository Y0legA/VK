// FriendPhotosViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

// Фото друга
class FriendPhotosViewController: UIViewController {
    // Private Constants
    enum Constants {
        static let emptyString = ""
    }

    // MARK: - Private IBoutlet

    @IBOutlet private var imageView: UIImageView!

    // MARK: - Private Visual Components

    // MARK: - Public Properties

    // MARK: - Private Properties

    private var friendPhotoNames: [String] = []
    private lazy var firstPhoto = friendPhotoNames.first
    private lazy var lastPhoto = friendPhotoNames.last
    private var currentPhoto = Constants.emptyString
    private var prevoiceIndex = 0
    private var currentPhotoIndex = 0

    // MARK: - Initializers

    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }

    // MARK: - Public Methods

    func configure(_ photos: [String]) {
        friendPhotoNames = photos
        print(photos)
    }

    // MARK: - Private IBAction

    // MARK: - Private Methods

    @objc private func swipeAction(_ gesture: UISwipeGestureRecognizer) {
        switch gesture.direction {
        case .left:
            guard currentPhoto != lastPhoto else { fallthrough }
            prevoiceIndex = currentPhotoIndex
            currentPhotoIndex += 1
            setCurrentPhoto(view.bounds.width)
        case .right:
            guard currentPhoto != firstPhoto else { fallthrough }
            prevoiceIndex = currentPhotoIndex
            currentPhotoIndex -= 1
            setCurrentPhoto(-view.bounds.width)
        case .down:
            swipeDown()
        default:
            return
        }
    }

    private func animatePhotoImageView(_ offSet: CGFloat) {
        UIView.animate(
            withDuration: 0.5,
            animations: {
                self.imageView.image = UIImage(named: self.friendPhotoNames[self.prevoiceIndex])
                self.imageView.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            },
            completion: { _ in
                self.imageView.transform = CGAffineTransform(translationX: offSet, y: 0)
                UIView.animate(withDuration: 1.0) {
                    self.imageView.image = UIImage(named: self.friendPhotoNames[self.currentPhotoIndex])
                    self.imageView.transform = .identity
                }
            }
        )
    }

    func animateTitle() {
        let fadeAnimation = CABasicAnimation(keyPath: "opacity")
        fadeAnimation.fromValue = 1
        fadeAnimation.toValue = 0
        fadeAnimation.duration = 1.0
        fadeAnimation.beginTime = CACurrentMediaTime() + 1
        fadeAnimation.fillMode = .backwards

        imageView.layer.add(fadeAnimation, forKey: nil)
    }

    private func setCurrentPhoto(_ offSet: CGFloat) {
        let photo = friendPhotoNames[currentPhotoIndex]
        print(photo)
        currentPhoto = photo
        imageView.image = UIImage(named: currentPhoto)
        animatePhotoImageView(offSet)
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

    private func configureLeftGesture() {
        let gesture = UISwipeGestureRecognizer(target: self, action: #selector(swipeAction))
        gesture.direction = .left
        imageView.addGestureRecognizer(gesture)
    }

    private func configureRightGesture() {
        let gesture = UISwipeGestureRecognizer(target: self, action: #selector(swipeAction))
        gesture.direction = .right
        imageView.addGestureRecognizer(gesture)
    }

    private func configureDownGesture() {
        let gesture = UISwipeGestureRecognizer(target: self, action: #selector(swipeAction))
        gesture.direction = .down
        imageView.addGestureRecognizer(gesture)
    }

    private func configureUI() {
        imageView.image = UIImage(named: firstPhoto ?? Constants.emptyString)
        imageView.isUserInteractionEnabled = true
        configureLeftGesture()
        configureRightGesture()
        configureDownGesture()
    }
}
