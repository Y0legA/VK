// Attachments.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Вложения новости
struct Attachment: Decodable {
    // Все фото друга
    let friendPhoto: FriendPhoto?

    enum CodingKeys: String, CodingKey {
        case friendPhoto = "photo"
    }
}
