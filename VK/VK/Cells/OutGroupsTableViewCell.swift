// OutGroupsTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

// Ячейка группы на которую не подписан пользователь
final class OutGroupsTableViewCell: UITableViewCell {
    // MARK: - Private IBOutlets

    @IBOutlet var groupImageView: UIImageView!
    @IBOutlet var groupNameLabel: UILabel!

    // MARK: - Public Methods

    func configureCell(_ group: Group) {
        groupImageView.image = UIImage(named: group.groupImageName)
        groupNameLabel.text = group.groupName
    }
}
