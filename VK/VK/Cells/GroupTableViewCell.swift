// GroupTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

// Ячейка группы пользователя
final class GroupTableViewCell: UITableViewCell {
    // MARK: - Private IBOutlets

    @IBOutlet var groupImageView: UIImageView!
    @IBOutlet var groupNameLabel: UILabel!

    // MARK: - Public methods

    func configureCell(_ group: Group) {
        groupImageView.image = UIImage(named: group.groupImageName)
        groupNameLabel.text = group.groupName
    }
}
