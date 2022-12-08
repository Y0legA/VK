// OutGroupsTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка группы на которую не подписан пользователь
final class OutGroupsTableViewCell: UITableViewCell {
    // MARK: - Private IBOutlet

    @IBOutlet private var groupImageView: UIImageView!
    @IBOutlet private var groupNameLabel: UILabel!

    // MARK: - Public Methods

    func configureCell(_ group: GroupDetail, _ networkService: NetworkService) {
        groupImageView.loadImage(group.photo200, networkService)
        groupNameLabel.text = group.name
    }
}
