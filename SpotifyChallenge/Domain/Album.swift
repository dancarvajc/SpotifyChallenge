//
//  Album.swift
//  SpotifyChallenge
//
//  Created by Daniel Carvajal on 08-12-22.
//

import Foundation

// MARK: - Album
struct Album: Identifiable, Codable {
    let totalTracks: Int
    let href, id: String
    let images: [SpotifyImage]
    let name: String?
    let releaseDate, releaseDatePrecision: String
    let artists: [Artist]
    
    enum CodingKeys: String, CodingKey {
        case totalTracks = "total_tracks"
        case href, id, images, name
        case releaseDate = "release_date"
        case releaseDatePrecision = "release_date_precision"
        case artists
    }
}

// MARK: - Image
struct SpotifyImage: Codable {
    let url: String
    let height, width: Int
}
