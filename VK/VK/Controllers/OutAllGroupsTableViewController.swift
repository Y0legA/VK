// OutAllGroupsTableViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

typealias Handler = (Group) -> ()

// Экран групп в которых не состоит пользователь
final class OutAllGroupsTableViewController: UITableViewController {
    // MARK: - Private Сonstants

    private enum Constants {
        static let outGroupCellIdentifier = "outGroupCell"
        static let lightMintColorName = "lightMintColor"
        static let lightPlaceholderMintColorName = "lightPlaceholderMintColor"
        static let adme = "ADME"
    }

    // MARK: - Private Visual Properties

    private let searchBar = UISearchBar()

    // MARK: - Public Properties

    var subscribeGroupHandler: Handler?

    // MARK: - Private Properties

    private var outGroups = groups {
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
    private var searchResults: [Group] = []
    private let networkService = NetworkService()

    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }

    // MARK: - Public Methods

    func configureGroups(_ userGroups: [Group], completion: @escaping Handler) {
        outGroups = outGroups.filter { outGroup in
            !userGroups.contains { userGroup in
                userGroup == outGroup
            }
        }
        subscribeGroupHandler = completion
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        isFiltering ? searchResults.count : outGroups.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: Constants.outGroupCellIdentifier,
            for: indexPath
        ) as? OutGroupsTableViewCell else { fatalError() }
        let group = isFiltering ? searchResults[indexPath.row] : outGroups[indexPath.row]
        cell.configureCell(group)
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        goUserGroups(indexPath)
    }

    // MARK: - Private Methods

    private func goUserGroups(_ indexPath: IndexPath) {
        let group = outGroups[indexPath.row]
        subscribeGroupHandler?(group)
        navigationController?.popViewController(animated: true)
    }

    private func configureUI() {
        configureSearchBar()
        configureTableView()
        networkService.fetchSearchGroups(Constants.adme)
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
}

// MARK: - UISearchBarDelegate

extension OutAllGroupsTableViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchResults = outGroups.filter { $0.groupName.lowercased().contains(searchText.lowercased()) }
        isSearching = true
        tableView.reloadData()
    }
}
