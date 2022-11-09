// FriendTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

// Ячейка друга
final class FriendTableViewCell: UITableViewCell {
    // MARK: - Private IBOutlet

    @IBOutlet private var friendNameLabel: UILabel!
    @IBOutlet private var avatarImageView: UIImageView!
    @IBOutlet private var avatarShadowView: AvatarView! {
        didSet {
            addRecogniser()
        }
    }

    // MARK: - Public Methods

    func configureCell(_ user: User) {
        avatarImageView.image = UIImage(named: user.avatarImageName)
        friendNameLabel.text = user.userName
    }

    // MARK: - Private Methods

    @objc private func tapedAction() {
        UIView.animate(
            withDuration: 2.0,
            delay: 0.0,
            usingSpringWithDamping: 0.3,
            initialSpringVelocity: 0.7,
            animations: {
                self.avatarImageView.frame.size.width += 10
                self.avatarImageView.frame.size.height += 10
            },
            completion: { [weak self] _ in
                self?.avatarImageView.frame.size.width -= 10
                self?.avatarImageView.frame.size.height -= 10
            }
        )
    }

    private func addRecogniser() {
        isUserInteractionEnabled = true
        let recogniser = UITapGestureRecognizer()
        recogniser.addTarget(self, action: #selector(tapedAction))
        recogniser.numberOfTapsRequired = 1
        avatarShadowView.addGestureRecognizer(recogniser)
    }
}
