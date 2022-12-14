// TableView+Extension.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Формирование сообщения при загрузке данных
extension UITableView {
    func showEmptyMessage(_ message: String) {
        let label = UILabel()
        label.textColor = .gray
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.text = message
        backgroundView = label
    }

    func hideEmptyMessage() {
        backgroundView = nil
    }
}
