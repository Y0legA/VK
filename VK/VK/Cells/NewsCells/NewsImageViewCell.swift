// NewsImageViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// NewsImageViewCell
final class NewsImageViewCell: UITableViewCell, NewsConfigurable {
    // MARK: - Private Constants

    private enum Constants {
        static let emptyString = " "
    }

    // MARK: - Private IBOutlet

    @IBOutlet private var postImageView: UIImageView!

    // MARK: - Public Methods

    func configure(_ news: Item) {
        let photos = news.attachments?.compactMap(\.friendPhoto)
    }
}
