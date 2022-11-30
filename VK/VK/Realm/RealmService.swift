// RealmService.swift
// Copyright © RoadMap. All rights reserved.

import RealmSwift

// Cервис базы данных Realm
final class RealmService {
    // MARK: - Public Properties

    let configuration = Realm.Configuration(deleteRealmIfMigrationNeeded: true)

    // MARK: - Public Methods

    func saveData<T: Object>(_ items: [T]) {
        do {
            let realm = try Realm(configuration: configuration)
            realm.beginWrite()
            realm.add(items, update: .modified)
            try realm.commitWrite()
        } catch {
            print(error)
        }
    }
}
