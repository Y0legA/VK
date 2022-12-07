// NetworkService.swift
// Copyright © RoadMap. All rights reserved.

import Alamofire
import RealmSwift

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

    func fetchFriends(completion: @escaping (Result<[Friend], Error>) -> ()) {
        let parameters: Parameters = [
            RequestComponents.acessTokenParameter: Session.shared.token,
            RequestComponents.fieldsParameter: RequestComponents.friendFieldsValue,
            RequestComponents.versionParameter: RequestComponents.versionParameterValue
        ]
        let path = Path.friends.rawValue
        AF.request(path, parameters: parameters).responseData { response in
            guard let data = response.value else { return }
            do {
                let users = try JSONDecoder().decode(User.self, from: data)
                let friends = users.friendInfo.friends
                completion(.success(friends))
            } catch {
                completion(.failure(error))
            }
        }
    }

    func fetchPhotos(_ friendID: Int, completion: @escaping (Result<Photo, Error>) -> ()) {
        let parameters: Parameters = [
            RequestComponents.acessTokenParameter: Session.shared.token,
            RequestComponents.versionParameter: RequestComponents.versionParameterValue,
            RequestComponents.extendedParameter: RequestComponents.extendedValue,
            RequestComponents.ownerIDParameter: friendID
        ]
        let path = Path.photos.rawValue
        AF.request(path, parameters: parameters).responseData { response in
            guard let data = response.value else { return }
            do {
                let photo = try JSONDecoder().decode(Photo.self, from: data)
                completion(.success(photo))
            } catch {
                completion(.failure(error))
            }
        }
    }

    func fetchGroups(completion: @escaping (Result<[GroupDetail], Error>) -> ()) {
        let parameters: Parameters = [
            RequestComponents.acessTokenParameter: Session.shared.token,
            RequestComponents.versionParameter: RequestComponents.versionParameterValue,
            RequestComponents.extendedParameter: RequestComponents.extendedValue
        ]
        let path = Path.groups.rawValue
        AF.request(path, parameters: parameters).responseData { response in
            guard let data = response.value else { return }
            do {
                let groups = try JSONDecoder().decode(Group.self, from: data)
                let items = groups.groupInfo.items
                completion(.success(items))
            } catch {
                completion(.failure(error))
            }
        }
    }

    func fetchSearchGroups(_ name: String, completion: @escaping (Result<[GroupDetail], Error>) -> ()) {
        let parameters: Parameters = [
            RequestComponents.acessTokenParameter: Session.shared.token,
            RequestComponents.versionParameter: RequestComponents.versionParameterValue,
            RequestComponents.queryParameter: name
        ]
        let path = Path.searchGroups.rawValue
        AF.request(path, parameters: parameters).responseData { response in
            guard let data = response.value else { return }
            do {
                let groupsSearch = try JSONDecoder().decode(Group.self, from: data)
                let groups = groupsSearch.groupInfo.items
                completion(.success(groups))
            } catch {
                completion(.failure(error))
            }
        }
    }

    func fetchNews(completion: @escaping (Result<NewsResponse, Error>) -> ()) {
        let parameters: Parameters = [
            RequestComponents.acessTokenParameter: Session.shared.token,
            RequestComponents.filter: RequestComponents.filterValue,
            RequestComponents.versionParameter: RequestComponents.versionParameterValue
        ]
        let path = Path.news.rawValue
        AF.request(path, parameters: parameters).responseData { response in
            guard let data = response.value else { return }
            do {
                let news = try JSONDecoder().decode(NewsResponse.self, from: data)
                completion(.success(news))
            } catch {
                completion(.failure(error))
            }
        }
    }
}
