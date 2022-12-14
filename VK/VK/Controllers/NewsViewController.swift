// NewsViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Экран с новостями
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
        static let loading = "Loading..."
        static let loadedText = "No news loaded"
    }

    // MARK: - Private Types

    private enum NewsType: Int, CaseIterable {
        case header
        case text
        case image
        case footer
    }

    // MARK: - Private IBOutlet

    @IBOutlet private var tableView: UITableView!

    // MARK: - Private Properties

    private let networkService = NetworkService()
    private var items: [Item] = []
    private var groupDetails: [GroupDetail] = []
    private var friends: [Friend] = []
    private var currentDate = 0
    private var nextFrom = Constants.emptyString
    private var isLoading = false

    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }

    // MARK: - Private Methods

    @objc private func refreshAction() {
        fetchNews()
        tableView.refreshControl?.endRefreshing()
    }

    private func configureUI() {
        configureTableView()
        fetchNews()
    }

    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.prefetchDataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        configurePullToRefresh()
    }

    private func fetchNews() {
        let date = items.first?.date ?? 0
        networkService.fetchNews(date + 10) { [weak self] response in
            guard let self else { return }
            switch response {
            case let .success(data):
                print(data.nextPage as Any)
                self.currentDate = data.items.last?.date ?? 0
                self.items = self.filterNews(data) + self.items
                self.nextFrom = data.nextPage ?? Constants.emptyString
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

    private func filterNews(_ news: NewsResponse) -> [Item] {
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
        return news.items
    }

    private func configurePullToRefresh() {
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.tintColor = .lightGray
        tableView.refreshControl?.attributedTitle = NSAttributedString(string: Constants.loading)
        tableView.refreshControl?.addTarget(self, action: #selector(refreshAction), for: .valueChanged)
    }

    private func fetchNextPage() {
        networkService.fetchNews(currentDate, nextFrom) { [weak self] response in
            guard let self = self else { return }
            switch response {
            case let .success(data):
                let indexSet = IndexSet(integersIn: self.items.count ..< self.items.count + data.items.count)
                let news = self.filterNews(data)
                self.currentDate = news.first?.date ?? 0
                self.items.append(contentsOf: data.items)
                self.tableView.insertSections(indexSet, with: .automatic)
                if let page = data.nextPage {
                    self.nextFrom = page
                }
                self.isLoading = false
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
}

// MARK: - UITableViewDataSource

extension NewsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        if items.isEmpty {
            tableView.showEmptyMessage(Constants.loadedText)
        } else {
            tableView.hideEmptyMessage()
        }
        return items.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        NewsType.allCases.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = items[indexPath.section]
        let cellType = NewsType(rawValue: indexPath.row)
        var cellIdentifier = Constants.emptyString
        switch cellType {
        case .header:
            cellIdentifier = Constants.newsHeaderCellIdentifier
        case .text:
            cellIdentifier = Constants.newsPostCellIdentifier
        case .image:
            cellIdentifier = Constants.newsImageCellIdentifier
        case .footer:
            cellIdentifier = Constants.newsFooterCellIdentifier
        default:
            break
        }
        guard let cell = tableView
            .dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? NewsCell
        else { return UITableViewCell() }
        cell.configure(item, networkService)
        return cell
    }
}

// MARK: - UITableViewDelegate

extension NewsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 2:
            let tableWidth = tableView.bounds.width
            let news = items[indexPath.section].attachments?.first?.friendPhoto?.photos.last?.aspectRatio ?? CGFloat()
            let cellHeight = tableWidth * news
            return cellHeight
        default:
            return UITableView.automaticDimension
        }
    }
}

extension NewsViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        guard let maxSection = indexPaths.map(\.section).max() else { return }
        if maxSection > items.count - 3, !isLoading {
            isLoading = true
            fetchNextPage()
        }
    }
}
