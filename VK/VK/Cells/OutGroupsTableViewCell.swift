// OutGroupsTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

// Ячейка группы на которую не подписан пользователь
final class OutGroupsTableViewCell: UITableViewCell {
    // MARK: - Private IBOutlet

    @IBOutlet private var groupImageView: UIImageView!
    @IBOutlet private var groupNameLabel: UILabel!

    // MARK: - Public Methods

    func configureCell(_ group: Group) {
        groupImageView.image = UIImage(named: group.groupImageName)
        groupNameLabel.text = group.groupName
    }
}
