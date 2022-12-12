// NetworkManager.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

// Сетевой слой
final class NetworkManager {
    // MARK: - Private Properties

    private let configuration = URLSessionConfiguration.default

    // MARK: - Public Methods

    func getFriends() {
        let session = URLSession(configuration: configuration)
        guard let url = URL(
            string: Url.baseUrl + Url.getFriends + Url.userToken + Url.friendsFields + Url.version
        ) else { return }
        let task = session.dataTask(with: url) { data, _, _ in
            guard let data = data else { return }
            let json = try? JSONSerialization.jsonObject(
                with: data,
                options: JSONSerialization.ReadingOptions.allowFragments
            )
            print(json as Any)
        }
        task.resume()
    }

    func getPhotos(_ friendId: Int) {
        let session = URLSession(configuration: configuration)
        guard let url = URL(
            string: Url.baseUrl + Url.getPhotos + Url.userToken + Url.extended + Url.friendId + String(friendId) + Url
                .version
        ) else { return }
        let task = session.dataTask(with: url) { data, _, _ in
            guard let data = data else { return }
            let json = try? JSONSerialization.jsonObject(
                with: data,
                options: JSONSerialization.ReadingOptions.allowFragments
            )
            print(json as Any)
        }
        task.resume()
    }

    func getGroups() {
        let session = URLSession(configuration: configuration)
        guard let url = URL(
            string: Url.baseUrl + Url.getGroups + Url.userToken + Url.extended + Url.version
        ) else { return }
        let task = session.dataTask(with: url) { data, _, _ in
            guard let data = data else { return }
            let json = try? JSONSerialization.jsonObject(
                with: data,
                options: JSONSerialization.ReadingOptions.allowFragments
            )
            print(json as Any)
        }
        task.resume()
    }

    func getSearchGroups(_ name: String) {
        let session = URLSession(configuration: configuration)
        guard let url = URL(
            string: Url.baseUrl + Url.getSearchGroups + Url.userToken + Url.searchName + name + Url.version
        ) else { return }
        let task = session.dataTask(with: url) { data, _, _ in
            guard let data = data else { return }
            let json = try? JSONSerialization.jsonObject(
                with: data,
                options: JSONSerialization.ReadingOptions.allowFragments
            )
            print(json as Any)
        }
        task.resume()
    }
}
