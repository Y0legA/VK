// Friend.swift
// Copyright © RoadMap. All rights reserved.

import RealmSwift

@objcMembers
// Friend
final class Friend: Object, Codable {
    enum CodingKeys: String, CodingKey {
           case id
           case photo100 = "photo_100"
           case firstName = "first_name"
           case lastName = "last_name"
       }
    dynamic var id: Int
    dynamic var photo100: String
    dynamic var firstName: String
    dynamic var lastName: String

    override static func primaryKey() -> String {
        "id"
    }
}
