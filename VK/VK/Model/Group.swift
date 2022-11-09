// Group.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

// Группа пользователя
struct Group: Equatable {
    let groupName: String
    let groupImageName: String

    init(_ groupImageName: String, _ groupName: String) {
        self.groupImageName = groupImageName
        self.groupName = groupName
    }
}
