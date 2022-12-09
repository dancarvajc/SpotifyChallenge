//
//  TokenManager.swift
//  SpotifyChallenge
//
//  Created by Daniel Carvajal on 09-12-22.
//

import Foundation

protocol TokenManagerProtocol {
    var keychain: KeychainManagerProtocol { get }
    func saveAccessToken(_ token: String) throws
    func saveRefreshToken(_ token: String) throws
    func getAccessToken() throws -> String?
    func getRefreshToken() throws -> String?
    func requestAccessToken(code: String) async throws
}

class TokenManager: TokenManagerProtocol {
    var keychain: KeychainManagerProtocol
    private let accessTokenKey: String = "accessToken"
    private let refreshTokenKey: String = "refreshToken"
    private let networkManager: NetworkManagerProtocol
    
    init(keychain: KeychainManagerProtocol = KeychainManager(), networkManager: NetworkManagerProtocol = NetworkManager()) {
        self.keychain = keychain
        self.networkManager = networkManager
    }
    
    func saveAccessToken(_ token: String) throws {
       try keychain.saveStringItem(token, key: accessTokenKey)
    }
    
    func saveRefreshToken(_ token: String) throws {
        try keychain.saveStringItem(token, key: refreshTokenKey)
    }
    
    func getAccessToken() throws -> String? {
        try keychain.getStringItem(key: accessTokenKey)
    }
    
    func getRefreshToken() throws -> String? {
        try keychain.getStringItem(key: refreshTokenKey)
    }
    
    func requestAccessToken(code: String) async throws {
        guard let requestURL = Endpoint.tokenRequest(code: code).urlRequest else {
            throw (URLError(.badURL))
        }
        let response: TokenResponse = try await networkManager.makeHTTPRequest(requestURL)
        try saveRefreshToken(response.refreshToken)
        try saveAccessToken(response.accessToken)
    }
}
