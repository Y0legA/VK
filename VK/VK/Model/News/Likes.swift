// Likes.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Likes
struct Likes: Codable {
    let count: Int?
    let userLikes: Int?

    enum CodingKeys: String, CodingKey {
        case count
        case userLikes = "user_likes"
    }
}
