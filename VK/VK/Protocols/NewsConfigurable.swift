// NewsConfigurable.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

typealias NewsCell = UITableViewCell & NewsConfigurable

protocol NewsConfigurable {
    func configure(_ news: Item)
}
