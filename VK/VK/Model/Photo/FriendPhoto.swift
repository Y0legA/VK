// FriendPhoto.swift
// Copyright © RoadMap. All rights reserved.

import RealmSwift

/// Фото друга
final class FriendPhoto: Object, Codable {
    /// идентификатор пользователя
    @Persisted(primaryKey: true) var id: Int
    /// идентификатор владельца фотографий
    @Persisted var ownerID: Int
    /// Список объектов
    @Persisted var photos = List<Photos>()

    enum CodingKeys: String, CodingKey {
        case id
        case ownerID = "owner_id"
        case photos = "sizes"
    }
}
