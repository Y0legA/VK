// User.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

// Друг пользователя
struct User {
    let avatarImageName: String
    let userName: String
    let likes: Int
    let isliked: Bool

    init(_ avatarImageName: String, _ userName: String, _ likes: Int, _ isLike: Bool) {
        self.avatarImageName = avatarImageName
        self.userName = userName
        self.likes = likes
        isliked = isLike
    }
}
