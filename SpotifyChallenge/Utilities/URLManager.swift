//
//  URLManager.swift
//  SpotifyChallenge
//
//  Created by Daniel Carvajal on 08-12-22.
//

import Foundation

protocol URLRequestProviderProtocol {
    func request(for endpoint: Endpoint) -> URLRequest?
    func url(for endpoint: Endpoint) -> URL?
}

struct URLManager: URLRequestProviderProtocol {
    private let tokenManager: TokenManagerProtocol
    
    init(tokenManager: TokenManagerProtocol = TokenManager()) {
        self.tokenManager = tokenManager
    }
    
    
    // Get the URLRequest aaccording to the endpoint type
    func request(for endpoint: Endpoint) -> URLRequest? {
        
        guard var finalURL = url(for: endpoint) else {
            return nil
        }

        var headers: [String: String]?
        var query: [String: String]?
        
        // Queries / headers are assigned according to the endpoint type
        switch endpoint {
        case .auth:
            query = [K.String.clientID: K.Spotify.clientID, K.String.responseType: K.String.code, K.String.redirectURI: K.Spotify.redirectURI]
        case .tokenRequest(let code):
            query = [
                K.String.grantType: K.String.authorizationCode,
                K.String.code: code,
                K.String.redirectURI: K.Spotify.redirectURI
            ]
            
            let authorization = "\(K.String.basic) " + (K.Spotify.clientID + ":" + K.Spotify.clientSecret).toBase64()
            
            headers = [
                K.String.contentType: K.String.applicationUrlencoded,
                K.String.authorization: authorization
            ]
        case .newReleases, .genres:
            guard let accessToken = try? tokenManager.getAccessToken() else {
                return nil
            }
            headers = [
                K.String.contentType: K.String.applicationJSON,
                K.String.authorization: "\(K.String.bearer) " + accessToken
            ]
        case .artists(let url):
            guard let artistURL = URL(string: url), let accessToken = try? tokenManager.getAccessToken() else {
                return nil
            }
            headers = [
                K.String.contentType: K.String.applicationJSON,
                K.String.authorization: "\(K.String.bearer) " + accessToken
            ]
            finalURL = artistURL // The url is replaced by the one provided by spotify
        }
        
        var urlRequest = URLRequest(url: finalURL)
        urlRequest.httpMethod = endpoint.httpMethod
        
        
        // Set query
        if let query {
            var urlComponent = URLComponents(string: finalURL.absoluteString)
            urlComponent?.queryItems = query.map { URLQueryItem(name: $0, value: $1) }
            urlRequest.url = urlComponent?.url
        }
        
        // Set headers
        if let headers {
            urlRequest.allHTTPHeaderFields = headers
        }
        
        return urlRequest
    }
    
    // Get the full URL aaccording to the endpoint type
    func url(for endpoint: Endpoint) -> URL? {
        let baseStringURL: String
        switch endpoint {
        case .auth, .tokenRequest:
            baseStringURL = Endpoint.baseURL2
        default:
            baseStringURL = Endpoint.baseURL
        }
        guard let baseURL = URL(string: baseStringURL) else {
            return nil
        }
        let finalURL = baseURL.appendingPathComponent(endpoint.stringURL)
        return finalURL
    }
}
