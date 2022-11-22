// Url.swift
// Copyright © RoadMap. All rights reserved.

// Составляющие запроса
enum Url {
    static let scheme = "https"
    static let host = "oauth.vk.com"
    static let path = "/authorize"
    static let clientId = "client_id"
    static let clientIdValue = "51483863"
    static let display = "display"
    static let displayValue = "mobile"
    static let blankHtml = "/blank.html"
    static let redirectUrl = "redirect_url"
    static let redirectUrlValue = "https://oauth.vk.com\(Url.blankHtml)"
    static let scope = "scope"
    static let scopeValue = "262150"
    static let responseType = "response_type"
    static let responseTypeValue = "token"
    static let vName = "v"
    static let vValue = "5.131"
    static let ampersand = "&"
    static let equal = "="
    static let searchName = "&q="
    static let version = Url.ampersand + Url.vName + Url.equal + Url.vValue
    static let token = "access_token"
    static let userToken = "?&access_token=\(Session.shared.token)"
    static let friendId = "&owner_id="
    static let baseUrl = "\(Url.scheme)://api.vk.com/method/"
    static let getFriends = "friends.get"
    static let friendsFields = "&fields=nickname"
    static let getPhotos = "photos.getAll"
    static let extended = "&extended=1"
    static let getGroups = "groups.get"
    static let getSearchGroups = "groups.search"
}
