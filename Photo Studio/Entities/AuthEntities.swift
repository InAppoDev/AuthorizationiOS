//
//  AuthEntities.swift
//  Photo Studio
//
//  Created by Дмитро Мостовий on 20.12.2020.
//

import Foundation

// MARK: - AuthResponse
struct AuthResponse: Codable {
    var accessToken: String
    var refreshToken: String
    var expiresIn: String

    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case refreshToken = "refresh_token"
        case expiresIn = "expires_in"
    }
}

// MARK: - SignupResponse
struct SignupResponse: Codable {
    var clientId: Int
    
    enum CodingKeys: String, CodingKey {
        case clientId = "client_id"
    }
}
