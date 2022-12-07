// NewsPostViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// NewsPostViewCell
final class NewsPostViewCell: NewsCell {
    // MARK: - Private IBOutlet

    @IBOutlet private var postTextView: UITextView!

    // MARK: - Public Methods

    func configure(_ news: Item) {
        postTextView.text = news.text
    }
}
