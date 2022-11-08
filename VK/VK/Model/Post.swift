// Post.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

// Модель поста
struct Post {
    let postImageName: String
    let avatarImageName: String
    let userName: String
    let date: String
    let likes: Int
    let isliked: Bool
    let postDescription: String

    init(
        _ postImageName: String,
        _ avatarImageName: String,
        _ userName: String,
        _ date: String,
        _ likes: Int,
        _ isLike: Bool,
        _ postDescription: String
    ) {
        self.postImageName = postImageName
        self.avatarImageName = avatarImageName
        self.userName = userName
        self.date = date
        self.likes = likes
        isliked = isLike
        self.postDescription = postDescription
    }
}
