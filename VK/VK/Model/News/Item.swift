// Item.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

// Детальная информаци по новости
final class Item: Decodable {
    // ID источника
    let sourceID: Int
    // Имя
    var name: String?
    // Фото URL
    var photoUrl: String?
    // Дата новости
    let date: Int
    // ID Пользователя
    let id: Int?
    // Заголовок новости
    let text: String?
    /// Вложения новости
    let attachments: [ItemAttachment]?
    // Инфо по лайкам
    let likes: Likes?
    // Инфо по просмотрам
    let views: Views?
    // Инфо по комментам
    let comments: Comments?
    // Инфо по репостам
    let reposts: Reposts?

    enum CodingKeys: String, CodingKey {
        case sourceID = "source_id"
        case date
        case id
        case text
        case attachments
        case likes
        case views
        case comments
        case reposts
    }
}
