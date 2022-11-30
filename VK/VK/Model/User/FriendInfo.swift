// FriendInfo.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

// FriendInfo
struct FriendInfo: Codable {
    let friends: [Friend]

    enum CodingKeys: String, CodingKey {
        case friends = "items"
    }
}
