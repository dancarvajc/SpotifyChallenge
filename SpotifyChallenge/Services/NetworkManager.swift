//
//  NetworkManager.swift
//  SpotifyChallenge
//
//  Created by Daniel Carvajal on 07-12-22.
//

import Foundation

protocol NetworkManagerProtocol {
    func makeHTTPRequest<T: Decodable>(_ request: URLRequest) async throws -> T
}

struct NetworkManager: NetworkManagerProtocol {
    // Generic function that allows you to make an HTTP request and decode it
    func makeHTTPRequest<T: Decodable>(_ request: URLRequest) async throws -> T {
        let (data, response) = try await URLSession.shared.data(for: request)
        
        // HTTP response is verified
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        // The data is decoded
        let dataDecoded = try JSONDecoder().decode(T.self, from: data)
        return dataDecoded
    }
}
