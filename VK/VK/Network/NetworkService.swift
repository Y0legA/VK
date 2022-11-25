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

    func fetchFriends(completion: @escaping ([Friend]) -> ()) {
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
                let value = users.friendInfo.friends
                completion(value)
            } catch {
                print(error)
            }
        }
    }

    func fetchPhotos(_ friendID: Int, completion: @escaping ([String], Int) -> ()) {
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
                let friendsDetail = try JSONDecoder().decode(Photo.self, from: data)
                let friendsDetailArray = friendsDetail.friendDetail.friendPhotos.map(\.photos.last)
                let photosUrl = friendsDetailArray.map { $0?.url ?? "" }
                let likes = friendsDetail.friendDetail.friendPhotos.map(\.likeCount.count)
                completion(photosUrl, likes.first ?? 0)
            } catch {
                print(error)
            }
        }
    }

    func fetchGroups(completion: @escaping ([GroupDetail]) -> ()) {
        let parameters: Parameters = [
            RequestComponents.acessTokenParameter: Session.shared.token,
            RequestComponents.versionParameter: RequestComponents.versionParameterValue,
            RequestComponents.extendedParameter: RequestComponents.extendedValue
        ]
        let path = Path.groups.rawValue
        AF.request(path, parameters: parameters).responseData { response in
            guard let data = response.value else { return }
            do {
                let groupsArray = try JSONDecoder().decode(Group.self, from: data)
                let groups = groupsArray.groupInfo.items
                completion(groups)
            } catch {
                print(error)
            }
        }
    }

    func fetchSearchGroups(_ name: String, completion: @escaping ([GroupDetail]) -> ()) {
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
                completion(groups)
            } catch {
                print(error)
            }
        }
    }

    func saveData<T: Object>(_ items: [T]) {
        do {
            let realm = try Realm()
            realm.beginWrite()
            realm.add(items)
            try realm.commitWrite()
        } catch {
            print(error)
        }
    }
}
