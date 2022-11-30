// GroupDetail.swift
// Copyright © RoadMap. All rights reserved.

import RealmSwift

// GroupDetail
final class GroupDetail: Object, Codable {
    @Persisted(primaryKey: true) var id = 0
    @Persisted var name: String
    @Persisted var photo200: String

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case photo200 = "photo_200"
    }
}
