// RequestComponents.swift
// Copyright © RoadMap. All rights reserved.

// Составляющие запроса
enum RequestComponents {
    static let baseURL = "https://api.vk.com/method/"
    static let acessTokenParameter = "access_token"
    static let versionParameter = "v"
    static let versionParameterValue = "5.131"
    static let fieldsParameter = "fields"
    static let friendFieldsValue = "nickname"
    static let extendedParameter = "extended"
    static let extendedValue = "1"
    static let ownerIDParameter = "owner_id"
    static let queryParameter = "q"
    static let friends = "friends.get"
    static let groups = "groups.get"
    static let allPhotos = "photos.getAll"
    static let searchGroups = "groups.search"

    static let scheme = "https"
    static let host = "oauth.vk.com"
    static let path = "/authorize"
    static let clientParameter = "client_id"
    static let clientParameterValue = "51483253"
    static let displayParameter = "display"
    static let displayParameterValue = "mobile"
    static let redirectParameter = "redirect_uri"
    static let redirectParameterValue = "https://oauth.vk.com/blank.html"
    static let scopeParameter = "scope"
    static let scopeParameterValue = "262150"
    static let responseParameter = "response_type"
    static let responseParameterValue = "token"
    static let tokenParameter = "access_token"
    static let blankParameter = "/blank.html"
    static let ampersand = "&"
    static let equal = "="
}
