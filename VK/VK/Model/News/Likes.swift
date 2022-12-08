// Likes.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Количество лайков
struct Likes: Codable {
    // Количество лайков всего
    let count: Int?
    // Количество лайков пользователя
    let userLikes: Int?

    enum CodingKeys: String, CodingKey {
        case count
        case userLikes = "user_likes"
    }
}
