// NewsTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

// Ячейка для постов
final class NewsTableViewCell: UITableViewCell {
    // MARK: - Private IBoutlet

    @IBOutlet private var postImageView: UIImageView!
    @IBOutlet private var likesControl: PostLikesControl!
    @IBOutlet private var postAuthorImageView: UIImageView!
    @IBOutlet private var nameLabel: UILabel!
    @IBOutlet private var postDateLabel: UILabel!
    @IBOutlet private var descriptionLabel: UILabel!
}
