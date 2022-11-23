// NetworkService.swift
// Copyright © RoadMap. All rights reserved.

import Alamofire
import Foundation

// VK API Сервис
final class NetworkService {
    // MARK: - Public Methods

    func setupURLComponents() -> URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = RequestComponents.scheme
        urlComponents.host = RequestComponents.host
        urlComponents.path = RequestComponents.path
        urlComponents.queryItems = [
            URLQueryItem(name: RequestComponents.clientParameter, value: RequestComponents.clientParameterValue),
            URLQueryItem(name: RequestComponents.displayParameter, value: RequestComponents.displayParameterValue),
            URLQueryItem(name: RequestComponents.redirectParameter, value: RequestComponents.redirectParameterValue),
            URLQueryItem(name: RequestComponents.scopeParameter, value: RequestComponents.scopeParameterValue),
            URLQueryItem(name: RequestComponents.responseParameter, value: RequestComponents.responseParameterValue),
            URLQueryItem(name: RequestComponents.versionParameter, value: RequestComponents.versionParameterValue)
        ]
        return urlComponents.url
    }
    
    func fetchFriends() {
        let parameters: Parameters = [
            RequestComponents.acessTokenParameter: Session.shared.token,
            RequestComponents.fieldsParameter: RequestComponents.friendFieldsValue,
            RequestComponents.versionParameter: RequestComponents.versionParameterValue
        ]
        let path = RequestComponents.baseURL + RequestComponents.friends
        AF.request(path, parameters: parameters).responseData { response in
            guard let value = response.value else { return }
            print(value)
        }
    }

    func fetchPhotos(_ friendID: Int) {
        let parameters: Parameters = [
            RequestComponents.acessTokenParameter: Session.shared.token,
            RequestComponents.versionParameter: RequestComponents.versionParameterValue,
            RequestComponents.extendedParameter: RequestComponents.extendedValue,
            RequestComponents.ownerIDParameter: -friendID
        ]
        let path = RequestComponents.baseURL + RequestComponents.allPhotos
        AF.request(path, parameters: parameters).responseData { response in
            guard let value = response.value else { return }
            print(value)
        }
    }

    func fetchGroups() {
        let parameters: Parameters = [
            RequestComponents.acessTokenParameter: Session.shared.token,
            RequestComponents.versionParameter: RequestComponents.versionParameterValue,
            RequestComponents.extendedParameter: RequestComponents.extendedValue
        ]
        let path = RequestComponents.baseURL + RequestComponents.groups
        AF.request(path, parameters: parameters).responseData { response in
            guard let value = response.value else { return }
            print(value)
        }
    }

    func fetchSearchGroups(_ name: String) {
        let parameters: Parameters = [
            RequestComponents.acessTokenParameter: Session.shared.token,
            RequestComponents.versionParameter: RequestComponents.versionParameterValue,
            RequestComponents.queryParameter: name
        ]
        let path = RequestComponents.baseURL + RequestComponents.searchGroups
        AF.request(path, parameters: parameters).responseData { response in
            guard let value = response.value else { return }
            print(value)
        }
    }
}
