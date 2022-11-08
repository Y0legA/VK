// NewsTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

// Ячейка для постов
final class NewsTableViewCell: UITableViewCell {
    // MARK: - Private IBoutlet

    @IBOutlet var postImageView: UIImageView!

    @IBOutlet var likesControl: PostLikesControl!
    @IBOutlet var postAuthorImageView: UIImageView!

    @IBOutlet var nameLabel: UILabel!

    @IBOutlet var postDateLabel: UILabel!

    @IBOutlet var descriptionLabel: UILabel!

    // MARK: - Private Visual Components

    // MARK: - Public Properties

    // MARK: - Private Properties

    // MARK: - Initializer

    // MARK: - Public Methods

    func configureData(_ post: Post) {
        postImageView.image = UIImage(named: post.postImageName)
        likesControl.configure(post.likes, post.isliked)
        postAuthorImageView.image = UIImage(named: post.avatarImageName)
        nameLabel.text = post.userName
        postDateLabel.text = post.date
        descriptionLabel.text = post.postDescription
    }

    // MARK: - Private IBAction

    // MARK: - Private Methods
}
