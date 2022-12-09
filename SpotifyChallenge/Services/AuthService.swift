//
//  AuthService.swift
//  SpotifyChallenge
//
//  Created by Daniel Carvajal on 07-12-22.
//

import Foundation
import AuthenticationServices

protocol AuthServiceProtocol {
    func presentAuthentication() throws
}

class AuthService: NSObject, AuthServiceProtocol {
    
    private let tokenManager: TokenManagerProtocol
    
    init(tokenManager: TokenManagerProtocol = TokenManager()) {
        self.tokenManager = tokenManager
    }
    
    // Show a browser and load the Spotify authentication page
    func presentAuthentication() throws {
        guard let authURL = Endpoint.auth.urlRequest?.url else { return }
        let authSession = ASWebAuthenticationSession(url: authURL, callbackURLScheme: K.String.callbackURLScheme) { [weak self] callbackURL, error in
            guard let self else { return }
            guard error == nil, let callbackURL else {
                return 
            }
            
            guard let code = self.findAuthorizationCode(on: callbackURL) else {
                return
            }
            
            // After getting the authorization code, access token is requested
            Task {
                try await self.tokenManager.requestAccessToken(code: code)
                
                // Send a notification to the NewReleases View to fetch the new releases
                NotificationCenter.default.post(name: .loggedIn, object: nil)
            }
        }
        authSession.presentationContextProvider = self
        authSession.start()
    }
    
    // Get the authorization code from the callback URL of ASWebAuthenticationSession
    private func findAuthorizationCode(on callbackURL: URL) -> String? {
        let queryItems = URLComponents(string: callbackURL.absoluteString)?.queryItems
        let code = queryItems?.filter({ $0.name == K.String.code }).first?.value
        return code
    }
}

extension AuthService: ASWebAuthenticationPresentationContextProviding {
    func presentationAnchor(for session: ASWebAuthenticationSession) -> ASPresentationAnchor {
        return ASPresentationAnchor()
    }
}
