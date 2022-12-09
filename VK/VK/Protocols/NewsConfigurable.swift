// NewsConfigurable.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

typealias NewsCell = UITableViewCell & NewsConfigurable

/// Протокол для ячеек новостей
protocol NewsConfigurable {
    func configure(_ news: Item, _ networkService: NetworkService)
}
