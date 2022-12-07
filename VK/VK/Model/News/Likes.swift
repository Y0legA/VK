// Likes.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Количество лайков
struct Likes: Codable {
    let count: Int?
    let userLikes: Int?

    enum CodingKeys: String, CodingKey {
        case count
        case userLikes = "user_likes"
    }
}
