// FriendsTableViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

// Экран друзей
final class FriendsTableViewController: UITableViewController {
    // MARK: - Private Constants

    private enum Constants {
        static let friendCellIdentifier = "friendCell"
        static let photoSegueIdentifier = "photoSegue"
        static let headerNibName = "FriendsSectionTableViewHeader"
        static let headerIdentifier = "header"
    }

    // MARK: - Private Properties

    private let userFriends = friends
    private var sortedSectionsFriendMap = [Character: [User]]()
    private var sortedFriends: [User] = []
    private var sectionTitles: [Character] = []
    private let networkService = NetworkService()

    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }

    // MARK: - Public Methods

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == Constants.photoSegueIdentifier,
              let collectionVC = segue.destination as? FriendPhotoCollectionViewController else { return }
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        guard let friend = sortedSectionsFriendMap[sectionTitles[indexPath.section]]?[indexPath.row] else { abort() }
        collectionVC.configureData(friend)
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        sortedSectionsFriendMap.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sortedSectionsFriendMap[sectionTitles[section]]?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: Constants.friendCellIdentifier,
            for: indexPath
        ) as? FriendTableViewCell else { fatalError() }
        guard let friend = sortedSectionsFriendMap[sectionTitles[indexPath.section]]?[indexPath.row] else { abort() }
        cell.configureCell(friend)
        return cell
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: Constants.headerIdentifier)
            as? FriendsSectionTableViewHeader else { return UITableViewHeaderFooterView() }
        let title = String(sectionTitles[section])
        header.configure(title)
        return header
    }

    // MARK: - Private Methods

    private func configureUI() {
        configureListFriends()
        configureTableView()
        networkService.fetchFriends()
    }

    private func configureTableView() {
        tableView.register(
            UINib(nibName: Constants.headerNibName, bundle: nil),
            forHeaderFooterViewReuseIdentifier: Constants.headerIdentifier
        )
    }

    private func configureListFriends() {
        for friend in userFriends {
            guard let firstLetter = friend.userName.first else { return }
            if sortedSectionsFriendMap[firstLetter] != nil {
                sortedSectionsFriendMap[firstLetter]?.append(friend)
            } else {
                sortedSectionsFriendMap[firstLetter] = [friend]
            }
        }
        sectionTitles = Array(sortedSectionsFriendMap.keys).sorted()
    }
}
