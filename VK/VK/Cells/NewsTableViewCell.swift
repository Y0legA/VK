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

    // MARK: - Public Methods

    func configureData(_ post: Post) {
        postImageView.image = UIImage(named: post.postImageName)
        likesControl.configure(post.likes, post.isliked)
        postAuthorImageView.image = UIImage(named: post.avatarImageName)
        nameLabel.text = post.userName
        postDateLabel.text = post.date
        descriptionLabel.text = post.postDescription
    }
}
