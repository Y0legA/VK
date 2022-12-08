// GetDataOperation.swift
// Copyright © RoadMap. All rights reserved.

import Alamofire

/// Форматирование данных
class GetDataOperation: AsyncOperation {
    // MARK: - Public Properties

    var data: Data?

    // MARK: - Private Properties

    private var request: DataRequest

    // MARK: - Initializator

    init(request: DataRequest) {
        self.request = request
    }

    // MARK: - Public Method

    override func cancel() {
        request.cancel()
        super.cancel()
    }

    override func main() {
        request.responseData(queue: DispatchQueue.global()) { [weak self] response in
            self?.data = response.data
            self?.state = .finished
        }
    }
}
