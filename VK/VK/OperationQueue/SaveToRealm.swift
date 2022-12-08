// SaveToRealm.swift
// Copyright © RoadMap. All rights reserved.

import RealmSwift

/// Передача данных
final class SaveToRealm: Operation {
    // MARK: - Public Methods

    override func main() {
        guard let parseData = dependencies.first as? ParseData else { return }
        RealmService.saveData(parseData.groupDetails)
    }
}
