// NewsFooterViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// NewsFooterViewCell
final class NewsFooterViewCell: UITableViewCell, NewsConfigurable {
    // MARK: - Private IBOutlet

    @IBOutlet private var likesControl: PostLikesControl!
    @IBOutlet private var commentCount: UIButton!
    @IBOutlet private var shareCount: UIButton!
    @IBOutlet private var viewsCountButton: UIButton!

    // MARK: - Public Methods

    func configure(_ news: Item) {
        likesControl.configure(news.likes?.count ?? 0)
        commentCount.setTitle(String(news.comments?.count ?? 0), for: .normal)
        shareCount.setTitle(String(news.reposts?.count ?? 0), for: .normal)
        viewsCountButton.setTitle(String(news.views?.count ?? 0), for: .normal)
    }
}
