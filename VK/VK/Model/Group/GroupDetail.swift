// GroupDetail.swift
// Copyright © RoadMap. All rights reserved.

import RealmSwift

/// GroupDetail
final class GroupDetail: Object, Codable {
    /// Идентификатор группы
    @Persisted(primaryKey: true) var id = 0
    /// Название группы
    @Persisted var name: String
    /// Фото группы
    @Persisted var photo200: String

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case photo200 = "photo_200"
    }
}
