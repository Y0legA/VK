// Photos.swift
// Copyright © RoadMap. All rights reserved.

import RealmSwift

// Photos
final class Photos: Object, Codable {
    @Persisted var url: String
}
