//
//  NewReleasesViewModel.swift
//  SpotifyChallenge
//
//  Created by Daniel Carvajal on 08-12-22.
//

import Foundation

@MainActor
class NewReleasesViewModel: ObservableObject {
    @Published var albums: [Album] = []
    @Published var selectedArtist: Artist?
    @Published var isLoading: Bool = false
    
    private let networkService: NetworkManagerProtocol
    private let tokenManager: TokenManagerProtocol
    private let authService: AuthServiceProtocol
    
    init(networkService: NetworkManagerProtocol = NetworkManager(), tokenManager: TokenManagerProtocol = TokenManager(), authService: AuthServiceProtocol = AuthService()) {
        self.networkService = networkService
        self.tokenManager = tokenManager
        self.authService = authService
    }
    
    func fetchAlbums() async {
        do {
            isLoading = true
            if let request = Endpoint.newReleases.urlRequest {
                let response: NewReleases = try await networkService.makeHTTPRequest(request)
                self.albums = response.albums.items
                isLoading = false
            } else {
                throw URLError(.cancelled)
            }
        } catch {
            print("--- error: \(error)")
            isLoading = false
        }
    }
    
    func fetchArtistInfo(_ url: String) async {
        do {
            guard let requestURL = Endpoint.artists(url).urlRequest else {
                throw URLError(.badURL)
            }
            let artist: Artist = try await networkService.makeHTTPRequest(requestURL)
            selectedArtist = artist
        } catch {
            print("--- error: \(error)")
        }
    }
    
    func removeSelectedArtist() {
        selectedArtist = nil
    }
    
    func presentAuthentication() {
        do {
            try authService.presentAuthentication()
        } catch {
            print("--- error: \(error)")
        }
        
    }
}


