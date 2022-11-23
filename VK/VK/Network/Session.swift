// Session.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

// Инфо о сессии пользователя
final class Session: CustomStringConvertible {
    // MARK: - Public Properties

    static let shared = Session()
    var description: String {
        "userId \(userID), token: \(token)"
    }

    // MARK: - Private Properties

    var token = ""
    var userID = 0

    // MARK: - Private Initializers

    private init() {}
}
