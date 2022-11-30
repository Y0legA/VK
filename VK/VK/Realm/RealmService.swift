// RealmService.swift
// Copyright © RoadMap. All rights reserved.

import RealmSwift

// Realm сервис
final class RealmService {
    let configuration = Realm.Configuration(deleteRealmIfMigrationNeeded: true)

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
