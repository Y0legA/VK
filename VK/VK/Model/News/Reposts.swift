// Reposts.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Репосты
struct Reposts: Codable {
    // Количество репостов
    let count: Int

    enum CodingKeys: String, CodingKey {
        case count
    }
}
