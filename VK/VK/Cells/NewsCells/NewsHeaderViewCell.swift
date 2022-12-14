// NewsHeaderViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Хедер ячейки новостей
final class NewsHeaderViewCell: NewsCell {
    // MARK: - Private Constants

    private enum Constants {
        static let emptyString = " "
    }

    // MARK: - Private IBOutlet

    @IBOutlet private var postAuthorImageView: UIImageView!
    @IBOutlet private var nameLabel: UILabel!
    @IBOutlet private var postDateLabel: UILabel!

    // MARK: - Public Methods

    func configure(_ news: Item, _ networkService: NetworkService) {
        postAuthorImageView.loadImage(news.photoUrl ?? Constants.emptyString, networkService)
        nameLabel.text = news.name
        postDateLabel.text = DateFormatter.convertData(news.date)
    }
}
