// GroupInfo.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Инфо по группе
struct GroupInfo: Codable {
    // Количество групп
    let count: Int
    // Детальная информация по группе
    let items: [GroupDetail]
}
