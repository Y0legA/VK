// FriendDetail.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

// FriendDetail
struct FriendDetail: Decodable {
    let friendPhotos: [FriendPhoto]

    enum CodingKeys: String, CodingKey {
        case friendPhotos = "items"
    }
}
