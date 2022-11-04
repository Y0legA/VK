// FriendTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

// Ячейка друга
final class FriendTableViewCell: UITableViewCell {
    // MARK: - Private IBOutlet

    @IBOutlet private var friendNameLabel: UILabel!
    @IBOutlet private var avatarView: UIImageView!
    @IBOutlet private var avatarShadowView: AvatarView!

    // MARK: - Public Methods

    func configureCell(_ user: User) {
        avatarView.image = UIImage(named: user.avatarImageName)
        friendNameLabel.text = user.userName
    }
}
