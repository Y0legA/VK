// NewsViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

// Экран с новостями
final class NewsViewController: UIViewController {
    // MARK: - Private Constants

    private enum Constants {
        static let newsCellIdentifier = "newsCell"
        static let photoSegueIdentifier = "photoSegue"
    }

    // MARK: - Private IBoutlet

    @IBOutlet var tableView: UITableView!

    // MARK: - Private Visual Components

    let myPosts = posts

    // MARK: - Public Properties

    // MARK: - Private Properties

    // MARK: - Initializers

    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        tableView.estimatedRowHeight = UITableView.automaticDimension
    }

    // MARK: - Public Methods

    // MARK: - Private IBAction

    private func configureUI() {
        tableView.delegate = self
        tableView.dataSource = self
    }

    // MARK: - Private Methods
}

// UITableViewDataSource
extension NewsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        posts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView
            .dequeueReusableCell(withIdentifier: Constants.newsCellIdentifier) as? NewsTableViewCell
        else { return UITableViewCell() }
        cell.configureData(posts[indexPath.row])
        return cell
    }
}

// UITableViewDelegate
extension NewsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) ->
        CGFloat
    {
        UITableView.automaticDimension
    }
}
