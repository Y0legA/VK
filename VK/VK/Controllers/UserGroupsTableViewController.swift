// UserGroupsTableViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

// Экран групп пользователя
final class UserGroupsTableViewController: UITableViewController {
    // MARK: - Private Constants

    private enum Constants {
        static let userGroupCellIdentifier = "UserGroupCell"
        static let outGroupsSegueIdentifier = "outGroups"
    }

    // MARK: - Private Properties

    private var userGroups = [testGroups.first].compactMap { $0 } {
        didSet {
            tableView.reloadData()
        }
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Public methods

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == Constants.outGroupsSegueIdentifier,
              let outGroupsVC = segue.destination as? OutAllGroupsTableViewController else { return }
        outGroupsVC.configureGroups(userGroups) { [weak self] selectedGroup in
            guard let self = self else { return }
            self.userGroups.insert(selectedGroup, at: 0)
        }
    }

    // MARK: - UITableViewDataSource

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        userGroups.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: Constants.userGroupCellIdentifier,
            for: indexPath
        ) as? GroupTableViewCell else { return GroupTableViewCell() }
        let group = userGroups[indexPath.row]
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
