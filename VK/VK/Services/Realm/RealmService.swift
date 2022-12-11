// RealmService.swift
// Copyright © RoadMap. All rights reserved.

import RealmSwift

/// Реалм сервис
final class RealmService {
    // MARK: - Private Properties

    private static let deleteIfMigration = Realm.Configuration(deleteRealmIfMigrationNeeded: true)

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

    static func loadData<T: Object>(
        _ type: T.Type,
        config: Realm.Configuration = Realm.Configuration.defaultConfiguration
    ) -> Results<T>? {
        do {
            let realm = try Realm()
            return realm.objects(type)
        } catch {
            print(error.localizedDescription)
        }
        return nil
    }

//    static func loadData<T: RealmFetchable>(completion: (Results<T>) -> ()) {
//        do {
//            let realm = try Realm()
//            let data = realm.objects(T.self)
//            completion(data)
//        } catch {
//            print(error.localizedDescription)
//        }
//    }
}

// static func loadData<T: Object>() -> Results<T>? {
//    do {
//        let realm = try Realm()
//        return realm.objects(T.self)
//    } catch {
//        print(error.localizedDescription)
//    }
//    return nil
// }
