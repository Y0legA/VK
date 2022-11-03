// OutAllGroupsTableViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

// Экран групп в которых не состоит пользователь
final class OutAllGroupsTableViewController: UITableViewController {
    // MARK: - Private Сonstants

    private enum Constants {
        static let outGroupCellIdentifier = "outGroupCell"
    }

    // MARK: - Public Properties

    var subscribeGroupClosure: ((Group) -> ())?

    // MARK: - Private properties

    private var outGroups = testGroups {
        didSet {
            tableView.reloadData()
        }
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Public Methods

    func configureGroups(_ userGroups: [Group], completion: @escaping (Group) -> ()) {
        outGroups = outGroups.filter { outGroup in
            !userGroups.contains { userGroup in
                userGroup == outGroup
            }
        }
        subscribeGroupClosure = completion
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
        let group = outGroups[indexPath.row]
        subscribeGroupClosure?(group)
        navigationController?.popViewController(animated: true)
    }
}
