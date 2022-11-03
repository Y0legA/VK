// User.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

// Модель друга пользователя
struct User {
    let avatarImageName: String
    let userName: String
    let description: String?
    let photoImageNames: [String]?

    init(_ avatarImageName: String, _ userName: String, _ description: String?, _ photoImageNames: [String]?) {
        self.avatarImageName = avatarImageName
        self.userName = userName
        self.description = description
        self.photoImageNames = photoImageNames
    }
}
