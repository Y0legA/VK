// Item.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Item
final class Item: Decodable {
    var sourceID: Int
    var name: String?
    var photoUrl: String?
    var date: Int
    var id: Int?
    var text: String?
    let attachments: [ItemAttachment]?
    var likes: Likes?
    var views: Views?
    var comments: Comments?
    var reposts: Reposts?

    enum CodingKeys: String, CodingKey {
        case sourceID = "source_id"
        case date
        case id
        case text
        case attachments
        case likes
        case views
        case comments
    }
}
