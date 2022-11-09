// UserGroupsTableViewController.swift
// Copyright © RoadMap. All rights reserved.

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

    private var userGroups =
        [groups.first ?? Group(groupName: Constants.emptyString, groupImageName: Constants.emptyString)]
    {
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

    private var searchResults: [Group] = []
    private var isSearching = false

    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }

    // MARK: - Public Methods

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == Constants.outGroupsSegueIdentifier,
              let outGroupsVC = segue.destination as? OutAllGroupsTableViewController else { return }
        outGroupsVC.configureGroups(userGroups) { [weak self] selectedGroup in
            guard let self = self else { return }
            self.userGroups.insert(selectedGroup, at: 0)
        }
    }

    // MARK: - Private Methods

    private func configureUI() {
        configureSearchBar()
        configureTableView()
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

    // MARK: - UITableViewDataSource

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        isFiltering ? searchResults.count : userGroups.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: Constants.userGroupCellIdentifier,
            for: indexPath
        ) as? GroupTableViewCell else { return GroupTableViewCell() }
        let group = isFiltering ? searchResults[indexPath.row] : userGroups[indexPath.row]
        cell.configureCell(group)
        return cell
    }

    // MARK: - UITableViewDelegate

    override func tableView(
        _ tableView: UITableView,
        commit editingStyle: UITableViewCell.EditingStyle,
        forRowAt indexPath: IndexPath
    ) {
        if editingStyle == .delete {
            userGroups.remove(at: indexPath.row)
        }
    }
}

// MARK: - UISearchBarDelegate

extension UserGroupsTableViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchResults = userGroups.filter { $0.groupName.lowercased().contains(searchText.lowercased()) }
        isSearching = true
        tableView.reloadData()
    }
}
