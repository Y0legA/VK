// DateFormatter+Extension.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Форматирование даты
extension DateFormatter {
    static func convertData(_ value: Int) -> String {
        let inputValue = TimeInterval(value)
        let date = Date(timeIntervalSince1970: inputValue)
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-dd-yy hh:mm"
        return formatter.string(from: date)
    }
}
