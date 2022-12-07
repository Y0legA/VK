// Photos.swift
// Copyright © RoadMap. All rights reserved.

import RealmSwift

/// Photos
final class Photos: Object, Codable {
    /// URL копии изображения
    @Persisted var url: String
}
