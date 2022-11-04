// OutAllGroupsTableViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

typealias Handler = (Group) -> ()
// Экран групп в которых не состоит пользователь
final class OutAllGroupsTableViewController: UITableViewController {
    // MARK: - Private Сonstants

    private enum Constants {
        static let outGroupCellIdentifier = "outGroupCell"
    }

    // MARK: - Public Properties

    var subscribeGroupHandler: Handler?

    // MARK: - Private properties

    private var outGroups = groups {
        didSet {
            tableView.reloadData()
        }
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

    private func goUserGroups(_ indexPath: IndexPath) {
        let group = outGroups[indexPath.row]
        subscribeGroupHandler?(group)
        navigationController?.popViewController(animated: true)
    }

    // MARK: - UITableViewDataSource

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

    // MARK: - UITableViewDelegate

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        goUserGroups(indexPath)
    }
}
