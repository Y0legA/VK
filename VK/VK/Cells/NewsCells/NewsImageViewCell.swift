// NewsImageViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка с фото поста новостей
final class NewsImageViewCell: NewsCell {
    // MARK: - Private Constants

    private enum Constants {
        static let emptyString = " "
    }

    // MARK: - Private IBOutlet

    @IBOutlet private var postImageView: UIImageView!

    // MARK: - Public Methods

    override func prepareForReuse() {
        super.prepareForReuse()
        postImageView.image = nil
    }

    func configure(_ news: Item, _ networkService: NetworkService) {
        guard let photo = news.attachments?.first?.friendPhoto?.photos.last?.url else { return }
        postImageView.loadImage(photo, networkService)
    }
}
