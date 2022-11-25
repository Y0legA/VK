// User.swift
// Copyright © RoadMap. All rights reserved.

import RealmSwift

// User
struct User: Decodable {
    let response: Response
}

// Response
struct Response: Decodable {
    let friends: [Friend]

    enum CodingKeys: String, CodingKey {
        case friends = "items"
    }
}

// Friend
final class Friend: Object, Decodable {
    @objc dynamic var id: Int
    @objc dynamic var photo100: String
    @objc dynamic var firstName: String
    @objc dynamic var lastName: String

    enum CodingKeys: String, CodingKey {
        case id
        case photo100 = "photo_100"
        case firstName = "first_name"
        case lastName = "last_name"
    }
}
