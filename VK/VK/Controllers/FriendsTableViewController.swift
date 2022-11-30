// FriendsTableViewController.swift
// Copyright © RoadMap. All rights reserved.

import RealmSwift
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

    private var userFriends: Results<Friend>?
    private var notificationToken: NotificationToken?
    private let realm = try? Realm()
    private var sortedSectionsFriendMap = [Character: [Friend]]()
    private var sortedFriends: [Friend] = []
    private var sectionTitles: [Character] = []
    private let networkService = NetworkService()
    private let realmService = RealmService()

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
        collectionVC.configureData(friend.photo100, friend.id)
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
        fetchRealmFriends()
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
        networkService.fetchFriends { [weak self] friend in
            guard let self = self else { return }
            switch friend {
            case let .success(data):
                self.realmService.saveData(data)
                self.configureListFriends()
                self.tableView.reloadData()
            case let .failure(error):
                print(error)
            }
        }
    }

    private func fetchRealmFriends() {
        do {
            print(realm?.configuration.fileURL ?? "")
            guard let friends = realm?.objects(Friend.self) else { return }
            addToken(friends)
            userFriends = friends
            fetchFriends()
        } catch {
            print(error.localizedDescription)
        }
    }

    private func addToken(_ result: Results<Friend>) {
        guard let userFriends = userFriends else { return }
        notificationToken = userFriends.observe { [weak self] changes in
            switch changes {
            case .initial:
                break
            case .update:
                self?.userFriends = result
                self?.tableView.reloadData()
            case let .error(error):
                print(error)
            }
        }
    }
}
