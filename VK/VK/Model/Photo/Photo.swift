// Photo.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

// Доступные фото друга
struct Photo: Decodable {
    // Детальное инфо о фото друга
    let friendDetail: FriendDetail

    enum CodingKeys: String, CodingKey {
        case friendDetail = "response"
    }
}
