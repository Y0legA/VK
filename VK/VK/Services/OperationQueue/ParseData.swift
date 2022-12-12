// ParseData.swift
// Copyright © RoadMap. All rights reserved.

import Alamofire

/// Асинхронная операция парсинга групп
final class ParseData: Operation {
    // MARK: - Public Properties

    var groupDetails: [GroupDetail] = []

    // MARK: - Public Methods

    override func main() {
        guard let getDataOperation = dependencies.first as? GetDataOperation,
              let data = getDataOperation.data else { return }
        do {
            let response = try JSONDecoder().decode(Group.self, from: data)
            groupDetails = response.groupInfo.items
        } catch {
            print(error.localizedDescription)
        }
    }
}
