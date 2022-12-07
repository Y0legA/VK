// Attachments.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// ItemAttachment
struct ItemAttachment: Decodable {
    let friendPhoto: FriendPhoto?

    enum CodingKeys: String, CodingKey {
        case friendPhoto = "photo"
    }
}
