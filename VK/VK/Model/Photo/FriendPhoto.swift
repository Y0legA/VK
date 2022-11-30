// FriendPhoto.swift
// Copyright © RoadMap. All rights reserved.

import RealmSwift

// FriendsPhoto
final class FriendPhoto: Object, Codable {
    @Persisted(primaryKey: true) var id: Int
    @Persisted var ownerID: Int
    @Persisted var photos = List<Photos>()

    enum CodingKeys: String, CodingKey {
        case id
        case ownerID = "owner_id"
        case photos = "sizes"
    }
}
