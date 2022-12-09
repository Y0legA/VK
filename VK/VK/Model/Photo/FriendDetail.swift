// FriendDetail.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Детальная информация о фотольбомах друга
struct FriendDetail: Codable {
    // Фото друга
    let friendPhotos: [FriendPhoto]

    enum CodingKeys: String, CodingKey {
        case friendPhotos = "items"
    }
}
