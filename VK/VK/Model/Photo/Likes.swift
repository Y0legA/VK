// Likes.swift
// Copyright © RoadMap. All rights reserved.

import RealmSwift

// Likes
final class Likes: Decodable {
    @objc dynamic var userLikes, count: Int

    enum CodingKeys: String, CodingKey {
        case userLikes = "user_likes"
        case count
    }
}
