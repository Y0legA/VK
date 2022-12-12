// FriendsTableViewController.swift
// Copyright © RoadMap. All rights reserved.

import PromiseKit
import RealmSwift
import UIKit

/// Экран друзей
final class FriendsTableViewController: UITableViewController {
    // MARK: - Private Constants

    private enum Constants {
        static let friendCellIdentifier = "friendCell"
        static let photoSegueIdentifier = "photoSegue"
        static let headerNibName = "FriendsSectionTableViewHeader"
        static let headerIdentifier = "header"
        static let emptyString = ""
        static let ok = "OK"
    }

    // MARK: - Private Properties

    private let promiseFriendsAPIService = PromiseFriendsAPIService()
    private var userFriends: Results<Friend>?
    private var notificationToken: NotificationToken?
    private var sortedSectionsFriendMap = [Character: [Friend]]()
    private var sortedFriends: [Friend] = []
    private var sectionTitles: [Character] = []

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
        collectionVC.title = friend.firstName
        collectionVC.configureData(friend.id)
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
        configureTableView()
        loadData()
    }

    private func configureTableView() {
        tableView.register(
            UINib(nibName: Constants.headerNibName, bundle: nil),
            forHeaderFooterViewReuseIdentifier: Constants.headerIdentifier
        )
    }

    private func configureListFriends() {
        guard let objects = userFriends else { return }
        for friend in objects {
            guard let firstLetter = friend.firstName.first else { return }
            if sortedSectionsFriendMap[firstLetter] != nil {
                sortedSectionsFriendMap[firstLetter]?.append(friend)
            } else {
                sortedSectionsFriendMap[firstLetter] = [friend]
            }
        }
        sectionTitles = Array(sortedSectionsFriendMap.keys).sorted()
    }

    private func fetchFriends() {
        firstly {
            promiseFriendsAPIService.fetchFriends()
        }.done { [weak self] friends in
            RealmService.saveData(friends)
            guard let self else { return }
            self.configureListFriends()
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }.catch { [weak self] error in
            self?.showAlert(
                title: Constants.ok,
                message: error.localizedDescription,
                actionTitle: Constants.emptyString,
                handler: nil
            )
        }
    }

    private func loadData() {
        guard let friends = RealmService.loadData(Friend.self) else { return }
        userFriends = friends
        addNotificationToken(friends)
        fetchFriends()
    }

    private func addNotificationToken(_ result: Results<Friend>) {
        guard let userFriends = userFriends else { return }
        notificationToken = userFriends.observe { [weak self] changes in
            guard let self = self else { return }
            switch changes {
            case .initial:
                break
            case .update:
                self.userFriends = result
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
