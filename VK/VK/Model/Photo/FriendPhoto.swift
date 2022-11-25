// FriendPhoto.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

// FriendsPhoto
struct FriendPhoto: Decodable {
    let photos: [Photos]
    let likeCount: Likes

    enum CodingKeys: String, CodingKey {
        case photos = "sizes"
        case likeCount = "likes"
    }
}
