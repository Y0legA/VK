// ServiceFriends.swift
// Copyright © RoadMap. All rights reserved.

import Alamofire
import PromiseKit

/// Сервис для получения данных друзей
final class ServiceFriends {
    // MARK: - Private Constants

    private enum Constants {
        static let emptyString = ""
    }

    // MARK: - Public Methods

    func fetchFriends() -> Promise<[Friend]> {
        let parameters: Parameters = [
            RequestComponents.acessTokenParameter: Session.shared.token,
            RequestComponents.versionParameter: RequestComponents.versionParameterValue,
            RequestComponents.fieldsParameter: RequestComponents.friendFieldsValue,
            RequestComponents.extendedParameter: RequestComponents.extendedValue
        ]
        let path = Path.friends.rawValue
        let promise = Promise<[Friend]> { resolver in
            AF.request(path, parameters: parameters).responseData { response in
                guard let data = response.data else { return }
                do {
                    let decoder = JSONDecoder()
                    let items = try decoder.decode(User.self, from: data)
                    resolver.fulfill(items.friendInfo.friends)
                } catch {
                    resolver.reject(error)
                }
            }
        }
        return promise
    }
}
