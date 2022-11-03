// FriendTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

// Ячейка друга
final class FriendTableViewCell: UITableViewCell {
    // MARK: - Private IBOutlets

    @IBOutlet private var friendImageView: UIImageView!
    @IBOutlet private var friendNameLabel: UILabel!

    // MARK: - Public Methods

    func configureCell(_ friend: User) {
        friendImageView.image = UIImage(named: friend.avatarImageName)
        friendNameLabel.text = friend.userName
    }
}
