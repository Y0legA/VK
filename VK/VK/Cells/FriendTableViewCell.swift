// FriendTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

// Ячейка друга
final class FriendTableViewCell: UITableViewCell {
    // MARK: - Private IBOutlet

    @IBOutlet private var friendNameLabel: UILabel!
    @IBOutlet private var avatarImageView: UIImageView!
    @IBOutlet private var avatarShadowView: AvatarView!

    // MARK: - Public Methods

    func configureCell(_ user: User) {
        avatarImageView.image = UIImage(named: user.avatarImageName)
        friendNameLabel.text = user.userName
    }
}
