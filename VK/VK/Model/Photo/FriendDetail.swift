// FriendDetail.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

// FriendDetail
struct FriendDetail: Codable {
    let friendPhotos: [FriendPhoto]

    enum CodingKeys: String, CodingKey {
        case friendPhotos = "items"
    }
}
