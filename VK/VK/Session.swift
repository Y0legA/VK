//
//  Session.swift
//  VK
//
//  Created by Олег Яковлев on 21.11.22.
//

import Foundation

// хранение данных пользователя
final class Session: CustomStringConvertible {
    // MARK: - Public Properties
    
    static let shared = Session()
    var description: String {
        return "userId \(userId), token: \(token)"
    }
    
    // MARK: - Private Properties
    private var token: String = ""
    private var userId: Int = 0
    
    // MARK: - Private Initializers
    private init() {}
}
