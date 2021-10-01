//
//  ApiStruckt.swift
//  Photo Studio
//
//  Created by Дмитро Мостовий on 20.12.2020.
//

import Foundation

struct Keys {
    static let autorithationToken = "Authorization"
    static let refreshToken = "refreshToken"
}

struct BaseRequests {
    static let baseURL = "http://test/"
    static let prefix: String = "Bearer " // required for the backend
}

struct AuthRequests {
    static let login = "oauth/v2/auth"
    static let refresh = "oauth/v2/refresh"
    static let signup = "oauth/v2/signup"
    static let verifyPhone = "oauth/v2/verify/"
}
