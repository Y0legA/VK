// FriendInfo.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Инфо о друге
struct FriendInfo: Codable {
    // Информация о друзьях
    let friends: [Friend]

    enum CodingKeys: String, CodingKey {
        case friends = "items"
    }
}
