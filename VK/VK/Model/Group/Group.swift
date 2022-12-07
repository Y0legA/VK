// Group.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Группа
struct Group: Decodable {
    /// Инфо по группе
    let groupInfo: GroupInfo

    enum CodingKeys: String, CodingKey {
        case groupInfo = "response"
    }
}
