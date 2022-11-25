// GroupDetail.swift
// Copyright © RoadMap. All rights reserved.

import RealmSwift

// GroupDetail
final class GroupDetail: Decodable {
    @objc dynamic var id: Int
    @objc dynamic var name: String
    @objc dynamic var photo200: String

    enum CodingKeys: String, CodingKey {
        case id, name
        case photo200 = "photo_200"
    }
}
