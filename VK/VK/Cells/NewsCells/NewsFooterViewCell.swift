// NewsFooterViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// NewsFooterViewCell
final class NewsFooterViewCell: NewsCell {
    // MARK: - Private IBOutlet

    @IBOutlet private var likesControl: PostLikesControl!
    @IBOutlet private var commentCountButton: UIButton!
    @IBOutlet private var shareCountButton: UIButton!
    @IBOutlet private var viewsCountButton: UIButton!

    // MARK: - Public Methods

    func configure(_ news: Item) {
        likesControl.configure(news.likes?.count ?? 0)
        commentCountButton.setTitle(String(news.comments?.count ?? 0), for: .normal)
        shareCountButton.setTitle(String(news.reposts?.count ?? 0), for: .normal)
        viewsCountButton.setTitle(String(news.views?.count ?? 0), for: .normal)
    }
}
