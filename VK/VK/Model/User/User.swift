// User.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

// Пользователь
struct User: Decodable {
    // Инфо о друге
    let friendInfo: FriendInfo

    enum CodingKeys: String, CodingKey {
        case friendInfo = "response"
    }
}
