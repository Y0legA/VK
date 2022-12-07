// NewsPostViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

// Пост ячейки новостей
final class NewsPostViewCell: NewsCell {
    // MARK: - Private IBOutlet

    @IBOutlet private var postTextView: UITextView!

    // MARK: - Public Methods

    func configure(_ news: Item, _ networkService: NetworkService) {
        postTextView.text = news.text
    }
}
