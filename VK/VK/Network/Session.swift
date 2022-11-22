// Session.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

// Хранение данных пользователя
final class Session: CustomStringConvertible {
    // MARK: - Public Properties

    static let shared = Session()
    var description: String {
        "userId \(userId), token: \(token)"
    }

    // MARK: - Private Properties

    var token = ""
    var userId = 0

    // MARK: - Private Initializers

    private init() {}
}
