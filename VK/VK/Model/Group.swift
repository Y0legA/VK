// Group.swift
// Copyright © RoadMap. All rights reserved.

import RealmSwift

// Group
struct Group: Decodable {
    let groupInfo: GroupInfo

    enum CodingKeys: String, CodingKey {
        case groupInfo = "response"
    }
}

// GroupInfo
struct GroupInfo: Decodable {
    let count: Int
    let items: [MyGroup]
}

// MyGroup
final class MyGroup: Decodable {
    @objc dynamic var id: Int
    @objc dynamic var name: String
    @objc dynamic var photo200: String

    enum CodingKeys: String, CodingKey {
        case id, name
        case photo200 = "photo_200"
    }
}
