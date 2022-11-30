// OutAllGroupsTableViewController.swift
// Copyright © RoadMap. All rights reserved.

import RealmSwift
import UIKit

// Экран групп в которых не состоит пользователь
final class OutAllGroupsTableViewController: UITableViewController {
    // MARK: - Private Сonstants
    
    private enum Constants {
        static let outGroupCellIdentifier = "outGroupCell"
        static let lightMintColorName = "lightMintColor"
        static let lightPlaceholderMintColorName = "lightPlaceholderMintColor"
        static let emptyString = ""
    }
    
    // MARK: - Private Visual Properties
    
    private let searchBar = UISearchBar()
    
    // MARK: - Private Properties
    
    private var outGroups: [GroupDetail] = [] {
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
    private let networkService = NetworkService()
    private let realmService = RealmService()
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        outGroups.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: Constants.outGroupCellIdentifier,
            for: indexPath
        ) as? OutGroupsTableViewCell else { fatalError() }
        let group = outGroups[indexPath.row]
        cell.configureCell(group)
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
    
    private func fetchSearchOutGroups(_ searchText: String) {
        networkService.fetchSearchGroups(searchText) { [weak self] groups in
            guard let self = self else { return }
            switch groups {
            case let .success(data):
                self.outGroups = data
                self.realmService.saveData(self.outGroups)
                self.tableView.reloadData()
            case let .failure(error):
                print(error)
            }
        }
    }
    
    private func fetchRealmOutGroups(_ searchText: String) {
        do {
            let realm = try Realm()
            let groups = Array(realm.objects(GroupDetail.self))
            if outGroups != groups {
                outGroups = groups
            } else {
                fetchSearchOutGroups(searchText)
            }
        } catch {
            print(error)
        }
    }
}

// MARK: - UISearchBarDelegate

extension OutAllGroupsTableViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        isSearching = true
        fetchSearchOutGroups(searchText)
    }
}
