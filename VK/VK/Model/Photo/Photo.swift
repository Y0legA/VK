// Photo.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

// Photo
struct Photo: Decodable {
    let friendDetail: FriendDetail

    enum CodingKeys: String, CodingKey {
        case friendDetail = "response"
    }
}
