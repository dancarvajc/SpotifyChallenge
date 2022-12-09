//
//  Constants.swift
//  SpotifyChallenge
//
//  Created by Daniel Carvajal on 07-12-22.
//

import Foundation

enum K {
    enum String {
        static let clientID = "client_id"
        static let responseType = "response_type"
        static let code = "code"
        static let redirectURI = "redirect_uri"
        static let grantType = "grant_type"
        static let authorizationCode = "authorization_code"
        static let authorization = "Authorization"
        static let contentType = "Content-Type"
        static let applicationUrlencoded = "application/x-www-form-urlencoded"
        static let applicationJSON = "application/json"
        static let basic = "Basic"
        static let callbackURLScheme = "spotify-challenge-login"
        static let bearer = "Bearer"
    }
    
    enum Spotify {
        #warning("Add here your client id and client secret")
        static let clientID = ""
        static let clientSecret = ""
        static let redirectURI = K.String.callbackURLScheme + "://callback"
    }
}
