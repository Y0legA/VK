// NewsHeaderViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

// Хедер ячейки новостей
final class NewsHeaderViewCell: NewsCell {
    // MARK: - Private Constants

    private enum Constants {
        static let emptyString = " "
        static let dateFormat = "MM-dd-yy hh:mm"
    }

    // MARK: - Private IBOutlet

    @IBOutlet private var postAuthorImageView: UIImageView!
    @IBOutlet private var nameLabel: UILabel!
    @IBOutlet private var postDateLabel: UILabel!

    // MARK: - Public Methods

    func configure(_ news: Item, _ networkService: NetworkService) {
        postAuthorImageView.loadImage(news.photoUrl ?? Constants.emptyString, networkService)
        nameLabel.text = news.name
        postDateLabel.text = convertData(news.date)
    }

    // MARK: - Private Methods

    private func convertData(_ value: Int) -> String {
        let inputValue = TimeInterval(value)
        let date = Date(timeIntervalSince1970: inputValue)
        let formatter = DateFormatter()
        formatter.dateFormat = Constants.dateFormat
        return formatter.string(from: date)
    }
}
