// Friend.swift
// Copyright © RoadMap. All rights reserved.

import RealmSwift

@objcMembers
/// Friend
final class Friend: Object, Codable {
    enum CodingKeys: String, CodingKey {
        case id
        case photo100 = "photo_100"
        case firstName = "first_name"
        case lastName = "last_name"
    }

    /// Идентификатор друга
    dynamic var id: Int
    /// Размер фото
    dynamic var photo100: String
    /// Имя друга
    dynamic var firstName: String
    /// Фамилия друга
    dynamic var lastName: String

    override static func primaryKey() -> String {
        "id"
    }
}
