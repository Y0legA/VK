// User.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

// User
struct User: Decodable {
    let friendInfo: FriendInfo

    enum CodingKeys: String, CodingKey {
        case friendInfo = "response"
    }
}
