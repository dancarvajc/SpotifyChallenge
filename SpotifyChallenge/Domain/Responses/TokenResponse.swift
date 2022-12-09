//
//  TokenResponse.swift
//  SpotifyChallenge
//
//  Created by Daniel Carvajal on 06-12-22.
//

import Foundation

struct TokenResponse: Decodable {
    let accessToken, tokenType: String
    let expiresIn: Int
    let refreshToken: String
    
    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case tokenType = "token_type"
        case expiresIn = "expires_in"
        case refreshToken = "refresh_token"
    }
}
