// Group.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Group
struct Group: Decodable {
    let groupInfo: GroupInfo

    enum CodingKeys: String, CodingKey {
        case groupInfo = "response"
    }
}
