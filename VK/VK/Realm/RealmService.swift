// RealmService.swift
// Copyright © RoadMap. All rights reserved.

import RealmSwift

//  Realm Cервис
final class RealmService {
    // MARK: - Public Properties

    let configuration = Realm.Configuration(deleteRealmIfMigrationNeeded: true)

    // MARK: - Public Methods

    func loadData<T: RealmFetchable>(completion: (Results<T>) -> ()) {
        do {
            let realm = try Realm()
            let data = realm.objects(T.self)
            completion(data)
        } catch {
            print(error.localizedDescription)
        }
    }

    func saveData<T: Object>(_ items: [T]) {
        do {
            let realm = try Realm(configuration: configuration)
            realm.beginWrite()
            realm.add(items, update: .modified)
            try realm.commitWrite()
        } catch {
            print(error.localizedDescription)
        }
    }
}
