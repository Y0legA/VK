// FriendsSectionTableViewHeader.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Хедер секций друзей
final class FriendsSectionTableViewHeader: UITableViewHeaderFooterView {
    // MARK: - Private IBOutlet

    @IBOutlet private var sectionLabel: UILabel!

    // MARK: - Public Methods

    func configure(_ nameLabel: String) {
        sectionLabel.text = nameLabel
    }
}
