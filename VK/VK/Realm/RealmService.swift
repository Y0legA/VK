// RealmService.swift
// Copyright © RoadMap. All rights reserved.

import RealmSwift

/// Реалм сервис
final class RealmService {
    // MARK: - Public Properties

    static let configuration = Realm.Configuration(deleteRealmIfMigrationNeeded: true)

    // MARK: - Public Methods

    static func saveData<T: Object>(_ items: [T]) {
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(items, update: .modified)
            }
        } catch {
            print(error.localizedDescription)
        }
    }

    static func loadData<T: RealmFetchable>(completion: (Results<T>) -> ()) {
        do {
            let realm = try Realm(configuration: configuration)
            print(realm.configuration.fileURL as Any)
            let data = realm.objects(T.self)
            completion(data)
        } catch {
            print(error.localizedDescription)
        }
    }
}
