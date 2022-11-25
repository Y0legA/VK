// Photo.swift
// Copyright © RoadMap. All rights reserved.

import RealmSwift

// Photo
struct Photo: Decodable {
    let friendDetail: FriendDetail

    enum CodingKeys: String, CodingKey {
        case friendDetail = "response"
    }
}

// FriendDetail
struct FriendDetail: Decodable {
    let friendsDetail: [FriendPhoto]

    enum CodingKeys: String, CodingKey {
        case friendsDetail = "items"
    }
}

// FriendsPhoto
struct FriendPhoto: Decodable {
    let photos: [Photos]
    let likes: Likes

    enum CodingKeys: String, CodingKey {
        case photos = "sizes"
        case likes
    }
}

// Photos
final class Photos: Object, Decodable {
    @objc dynamic var url: String
}

// Likes
final class Likes: Decodable {
    @objc dynamic var userLikes, count: Int

    enum CodingKeys: String, CodingKey {
        case userLikes = "user_likes"
        case count
    }
}
