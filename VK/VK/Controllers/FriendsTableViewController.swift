// FriendsTableViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

// Экран друзей
final class FriendsTableViewController: UITableViewController {
    // MARK: - Private Constants

    private enum Constants {
        static let identifierFriendCell = "friendCell"
        static let identifierPhotoSegue = "photoSegue"
    }

    // MARK: - Private Properties

    private let userFriends = friends

    // MARK: - Public Methods

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == Constants.identifierPhotoSegue,
              let collectionVC = segue.destination as? FriendPhotoCollectionViewController else { return }
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        let friend = friends[indexPath.row]
        collectionVC.configureData(friend)
    }

    // MARK: - TableViewDataSource

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        friends.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: Constants.identifierFriendCell,
            for: indexPath
        ) as? FriendTableViewCell else { fatalError() }
        cell.configureCell(friends[indexPath.row])
        return cell
    }
}
