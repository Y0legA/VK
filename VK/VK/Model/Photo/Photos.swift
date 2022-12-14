// Photos.swift
// Copyright © RoadMap. All rights reserved.

import RealmSwift

/// Фото
final class Photos: Object, Codable {
    // URL копии изображения
    @Persisted var url: String
    // Ширина изображения
    @Persisted var width: Int
    // Высота изображения
    @Persisted var height: Int

    var aspectRatio: CGFloat {
        CGFloat(height) / CGFloat(width)
    }

    override class func primaryKey() -> String? {
        "url"
    }
}
