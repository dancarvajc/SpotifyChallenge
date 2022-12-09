//
//  AvailableGenresViewModel.swift
//  SpotifyChallenge
//
//  Created by Daniel Carvajal on 08-12-22.
//

import Foundation

@MainActor
class AvailableGenresViewModel: ObservableObject {
    @Published var genres: [String] = []
    @Published var isLoading: Bool = false
    private let networkService: NetworkManagerProtocol
    private let tokenManager: TokenManagerProtocol
    
    init(networkService: NetworkManagerProtocol = NetworkManager(), tokenManager: TokenManagerProtocol = TokenManager()) {
        self.networkService = networkService
        self.tokenManager = tokenManager
    }
    
    func fetchGenres() async {
        do {
            isLoading = true
            
            if let request = Endpoint.genres.urlRequest {
                let response: GenresResponse = try await networkService.makeHTTPRequest(request)
                self.genres = response.genres
                isLoading = false
            } else {
                throw URLError(.cancelled)
            }
        } catch {
            print("--- error: \(error)")
            isLoading = false
        }
    }
    
}
