// OutAllGroupsTableViewController.swift
// Copyright © RoadMap. All rights reserved.

import RealmSwift
import UIKit

/// Экран групп в которых не состоит пользователь
final class OutAllGroupsTableViewController: UITableViewController {
    // MARK: - Private Сonstants

    private enum Constants {
        static let outGroupCellIdentifier = "outGroupCell"
        static let lightMintColorName = "lightMintColor"
        static let lightPlaceholderMintColorName = "lightPlaceholderMintColor"
        static let emptyString = ""
        static let ok = "OK"
    }

    // MARK: - Private Visual Properties

    private let searchBar = UISearchBar()

    // MARK: - Private Properties

    private let networkService = NetworkService()

    private var outGroups: Results<GroupDetail>? {
        didSet {
            tableView.reloadData()
        }
    }

    private var searchResultIsEmpty: Bool {
        guard let text = searchBar.text else { return false }
        return text.isEmpty
    }

    private var isFiltering: Bool {
        isSearching && !searchResultIsEmpty
    }

    private var isSearching = false
    private var searchResults: [GroupDetail] = []
    private var notificationToken: NotificationToken?

    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        outGroups?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: Constants.outGroupCellIdentifier,
            for: indexPath
        ) as? OutGroupsTableViewCell, let groups = outGroups else { return OutGroupsTableViewCell() }
        let group = groups[indexPath.row]
        cell.configureCell(group, networkService)
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        goUserGroups(indexPath)
    }

    // MARK: - Private Methods

    private func goUserGroups(_ indexPath: IndexPath) {
        navigationController?.popViewController(animated: true)
    }

    private func configureUI() {
        configureSearchBar()
        configureTableView()
        loadData()
    }

    private func configureSearchBar() {
        searchBar.frame = CGRect(x: 0, y: 0, width: view.bounds.width - 40, height: 70)
        searchBar.center.x = view.center.x
        searchBar.delegate = self
        searchBar.searchTextField.backgroundColor = UIColor(named: Constants.lightPlaceholderMintColorName)
        searchBar.barTintColor = UIColor(named: Constants.lightMintColorName)
        searchBar.showsSearchResultsButton = true
        searchBar.searchBarStyle = UISearchBar.Style.default
        searchBar.sizeToFit()
    }

    private func configureTableView() {
        tableView.tableHeaderView = searchBar
    }

    private func fetchSearchOutGroups() {
        networkService.fetchGroups { [weak self] groups in
            guard let self = self else { return }
            switch groups {
            case let .success(data):
                RealmService.saveData(data)
                self.tableView.reloadData()
            case let .failure(error):
                self.showAlert(
                    title: Constants.emptyString,
                    message: error.localizedDescription,
                    actionTitle: Constants.ok,
                    handler: nil
                )
            }
        }
    }

    private func loadData() {
        RealmService.loadData { groups in
            self.addNotificationToken(groups)
            self.outGroups = groups
            tableView.reloadData()
        }
    }

    private func addNotificationToken(_ result: Results<GroupDetail>) {
        guard let userGroups = outGroups else { return }
        notificationToken = userGroups.observe { [weak self] changes in
            guard let self = self else { return }
            switch changes {
            case .initial:
                break
            case .update:
                self.outGroups = result
                self.tableView.reloadData()
            case let .error(error):
                self.showAlert(
                    title: Constants.emptyString,
                    message: error.localizedDescription,
                    actionTitle: Constants.ok,
                    handler: nil
                )
            }
        }
    }
}

// MARK: - UISearchBarDelegate

extension OutAllGroupsTableViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let groups = outGroups else { return }
        searchResults = groups.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        isSearching = true
        tableView.reloadData()
    }
}
