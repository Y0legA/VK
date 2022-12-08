// News.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Новости
struct NewsResponse: Decodable {
    // Новости
    var items: [Item]
    // Группы
    var groupDetail: [GroupDetail]
    // Друзья
    var friends: [Friend]

    enum CodingKeys: String, CodingKey {
        case response
        case items
        case groupDetail = "groups"
        case friends = "profiles"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: NewsResponse.CodingKeys.self)
        let responseContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .response)
        items = try responseContainer.decode([Item].self, forKey: .items)
        groupDetail = try responseContainer.decode([GroupDetail].self, forKey: .groupDetail)
        friends = try responseContainer.decode([Friend].self, forKey: .friends)
    }
}
