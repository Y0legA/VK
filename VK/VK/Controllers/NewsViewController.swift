// NewsViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

// Экран с новостями
final class NewsViewController: UIViewController {
    // MARK: - Private Constants

    private enum Constants {
        static let space = " "
        static let emptyString = ""
        static let newsHeaderCellIdentifier = "newsHeaderCell"
        static let newsPostCellIdentifier = "newsPostCell"
        static let newsImageCellIdentifier = "newsImageCell"
        static let newsFooterCellIdentifier = "newsFooterCell"
        static let photoSegueIdentifier = "photoSegue"
    }

    // MARK: - Private Types

    private enum NewsType: Int, CaseIterable {
        case header
        case content
        case footer
    }

    // MARK: - Private IBOutlet

    @IBOutlet private var tableView: UITableView!

    // MARK: - Private Properties

    private let networkService = NetworkService()

    private var news: [Item] = []
    private var groups: [GroupDetail] = []
    private var profile: [Friend] = []

    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }

    // MARK: - Private Methods

    private func configureUI() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = UITableView.automaticDimension
        fetchNews()
    }

    private func fetchNews() {
        networkService.fetchNews { [weak self] response in
            guard let self else { return }
            switch response {
            case let .success(data):
                self.filterNews(data)
                self.tableView.reloadData()
            case let .failure(error):
                self.showAlert(
                    title: nil,
                    message: error.localizedDescription,
                    actionTitle: Constants.emptyString,
                    handler: nil
                )
            }
        }
    }

    private func filterNews(_ news: NewsResponse) {
        news.items.forEach { item in
            if item.sourceID < 0 {
                guard let group = news.groupDetail.filter({ group in
                    group.id == -item.sourceID
                }).first else { return }
                item.name = group.name
                item.photoUrl = group.photo200
            } else {
                guard let friend = news.friends.filter({ friend in
                    friend.id == item.sourceID
                }).first else { return }
                item.name = friend.firstName + Constants.space + friend.lastName
                item.photoUrl = friend.photo100
            }
        }
        DispatchQueue.main.async {
            self.news = news.items
            self.tableView.reloadData()
        }
    }
}

// MARK: - UITableViewDataSource

extension NewsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        news.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        NewsType.allCases.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = news[indexPath.section]
        let cellType = NewsType(rawValue: indexPath.row) ?? .content
        var cellIdentifier = Constants.emptyString
        switch cellType {
        case .header:
            cellIdentifier = Constants.newsHeaderCellIdentifier
        case .content:
            cellIdentifier = Constants.newsPostCellIdentifier
        case .footer:
            cellIdentifier = Constants.newsFooterCellIdentifier
        }
        guard let cell = tableView
            .dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? NewsCell
        else { return UITableViewCell() }
        cell.configure(item)
        return cell
    }
}

// MARK: - UITableViewDelegate

extension NewsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) ->
        CGFloat { UITableView.automaticDimension }
}
