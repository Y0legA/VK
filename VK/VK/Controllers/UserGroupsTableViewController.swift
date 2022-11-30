// UserGroupsTableViewController.swift
// Copyright © RoadMap. All rights reserved.

import RealmSwift
import UIKit

// Экран групп пользователя
final class UserGroupsTableViewController: UITableViewController {
    // MARK: - Private Constants

    private enum Constants {
        static let userGroupCellIdentifier = "UserGroupCell"
        static let outGroupsSegueIdentifier = "outGroups"
        static let emptyString = ""
        static let photoSegueIdentifier = "photoSegue"
        static let headerNibName = "GroupTableViewHeader"
        static let headerIdentifier = "header"
        static let enterGroup = "Введите название группы.."
        static let lightMintColorName = "lightMintColor"
        static let lightPlaceholderMintColorName = "lightPlaceholderMintColor"
    }

    // MARK: - Private Visual Properties

    private let searchBar = UISearchBar()

    // MARK: - Private Properties

    private let networkService = NetworkService()
    private let realmService = RealmService()

    private var userGroups: Results<GroupDetail>? {
        didSet {
            tableView.reloadData()
        }
    }

    private var isFiltering: Bool {
        isSearching && !searchResultIsEmpty
    }

    private var searchResultIsEmpty: Bool {
        guard let text = searchBar.text else { return false }
        return text.isEmpty
    }

    private var searchResults: [GroupDetail] = []
    private var isSearching = false
    private var notificationToken: NotificationToken?

    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }

    // MARK: - Public Methods

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let count = userGroups?.count else { return 0 }
        return count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: Constants.userGroupCellIdentifier,
            for: indexPath
        ) as? GroupTableViewCell, let userGroups = userGroups else { return GroupTableViewCell() }
        cell.configureCell(userGroups[indexPath.row])
        return cell
    }

    // MARK: - Private Methods

    private func configureUI() {
        configureSearchBar()
        configureTableView()
        loadData()
    }

    private func configureSearchBar() {
        searchBar.frame = CGRect(x: 0, y: 0, width: view.bounds.width - 40, height: 70)
        searchBar.center.x = view.center.x
        searchBar.delegate = self
        searchBar.showsSearchResultsButton = true
        searchBar.searchBarStyle = UISearchBar.Style.default
        searchBar.placeholder = Constants.enterGroup
        searchBar.searchTextField.backgroundColor = UIColor(named: Constants.lightPlaceholderMintColorName)
        searchBar.barTintColor = UIColor(named: Constants.lightMintColorName)
        searchBar.sizeToFit()
    }

    private func configureTableView() {
        tableView.tableHeaderView = searchBar
        tableView.register(
            UINib(nibName: Constants.headerNibName, bundle: nil),
            forHeaderFooterViewReuseIdentifier: Constants.headerIdentifier
        )
    }

    private func fetchGroups() {
        networkService.fetchGroups { [weak self] group in
            guard let self = self else { return }
            switch group {
            case let .success(data):
                self.realmService.saveData(data)
                self.tableView.reloadData()
            case let .failure(error):
                self.showAlert(title: nil, message: error.localizedDescription, actionTitle: nil, handler: nil)
            }
        }
    }

    private func loadData() {
        realmService.loadData { [weak self] groups in
            guard let self = self else { return }
            self.userGroups = groups
            self.addNotificationToken(groups)
            self.fetchGroups()
        }
    }

    private func addNotificationToken(_ result: Results<GroupDetail>) {
        guard let userGroups = userGroups else { return }
        notificationToken = userGroups.observe { [weak self] changes in
            switch changes {
            case .initial:
                break
            case .update:
                self?.userGroups = result
                self?.tableView.reloadData()
            case let .error(error):
                self?.showAlert(title: nil, message: error.localizedDescription, actionTitle: nil, handler: nil)
            }
        }
    }
}

// MARK: - UISearchBarDelegate

extension UserGroupsTableViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let groups = userGroups else { return }
        searchResults = groups.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        isSearching = true
        tableView.reloadData()
    }
}
