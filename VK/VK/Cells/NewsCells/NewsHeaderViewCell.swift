// NewsHeaderViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// NewsHeaderViewCell
final class NewsHeaderViewCell: UITableViewCell, NewsConfigurable {
    // MARK: - Private Constants

    private enum Constants {
        static let emptyString = " "
        static let dateFormat = "MM-dd-yyyy Hh:mm"
    }

    // MARK: - Private IBOutlet

    @IBOutlet private var postAuthorImageView: UIImageView!
    @IBOutlet private var nameLabel: UILabel!
    @IBOutlet private var postDateLabel: UILabel!

    // MARK: - Public Methods

    func configure(_ news: Item) {
        postAuthorImageView.loadImage(urlImage: news.photoUrl ?? Constants.emptyString)
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
