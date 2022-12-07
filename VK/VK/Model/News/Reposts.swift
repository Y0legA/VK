// Reposts.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Количество репостов
struct Reposts: Codable {
    let count: Int

    enum CodingKeys: String, CodingKey {
        case count
    }
}
