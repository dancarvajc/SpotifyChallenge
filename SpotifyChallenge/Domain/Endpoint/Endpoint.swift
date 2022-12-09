//
//  Endpoint.swift
//  SpotifyChallenge
//
//  Created by Daniel Carvajal on 07-12-22.
//

import Foundation

enum Endpoint {
    
    static let baseURL = "https://api.spotify.com/v1"
    static let baseURL2 = "https://accounts.spotify.com"
    
    case auth, tokenRequest(code: String), newReleases, genres, artists(String)
    
    var stringURL: String {
        switch self {
        case .auth:
            return "/authorize"
        case .tokenRequest:
            return "/api/token"
        case .newReleases:
            return "/browse/new-releases"
        case .genres:
            return "/recommendations/available-genre-seeds"
        case .artists(let url):
            return url
        }
    }
    
    var urlRequest: URLRequest? {
        let urlManager = URLManager()
        return urlManager.request(for: self)
    }
    
    var httpMethod: String {
        switch self {
        case .tokenRequest:
            return "POST"
        default:
            return "GET"
        }
    }
}
