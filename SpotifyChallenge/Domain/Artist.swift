//
//  Artist.swift
//  SpotifyChallenge
//
//  Created by Daniel Carvajal on 09-12-22.
//

import Foundation

// MARK: - Artist
struct Artist: Codable {
    let followers: Followers?
    let genres: [String]?
    let href, id: String
    let images: [SpotifyImage]?
    let name: String
    let popularity: Int?
    
    enum CodingKeys: String, CodingKey {
        case followers, genres, href, id, images, name, popularity
    }
}

extension Artist {
    var popularityFormatted: String {
        if let popularity = NumberFormatter.basic.string(for: popularity) {
            return "\(popularity)/100"
        } else {
            return "No data"
        }
    }
}

// MARK: - Followers
struct Followers: Codable {
    let href: String?
    let total: Int
}

extension Followers {
    var totalFormatted: String {
        NumberFormatter.basic.string(for: total) ?? "No data"
    }
}

