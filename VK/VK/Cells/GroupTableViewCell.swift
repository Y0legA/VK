// GroupTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

// Ячейка группы пользователя
final class GroupTableViewCell: UITableViewCell {
    // MARK: - Private IBOutlet

    @IBOutlet private var groupImageView: UIImageView!
    @IBOutlet private var groupNameLabel: UILabel!

    // MARK: - Public Methods

    func configureCell(_ group: Group) {
        groupImageView.image = UIImage(named: group.groupImageName)
        groupNameLabel.text = group.groupName
    }

    // MARK: - Private IBAction

    @IBAction private func animationAction(_ sender: Any) {
        UIView.animate(
            withDuration: 2.0,
            delay: 0.0,
            usingSpringWithDamping: 0.3,
            initialSpringVelocity: 0.7,
            animations: {
                self.groupImageView.frame.size.width += 10
                self.groupImageView.frame.size.height += 10
            },
            completion: { _ in
                self.groupImageView.frame.size.width -= 10
                self.groupImageView.frame.size.height -= 10
            }
        )
    }
}
