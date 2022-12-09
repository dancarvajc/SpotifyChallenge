//
//  Extensions.swift
//  SpotifyChallenge
//
//  Created by Daniel Carvajal on 08-12-22.
//

import Foundation


// Ref: https://stackoverflow.com/a/35360697/19040271
extension String {
    func fromBase64() -> String? {
        guard let data = Data(base64Encoded: self) else {
            return nil
        }
        return String(data: data, encoding: .utf8)
    }
    
    func toBase64() -> String {
        return Data(self.utf8).base64EncodedString()
    }
}

// Ref: https://www.hackingwithswift.com/example-code/strings/how-to-capitalize-the-first-letter-of-a-string
extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}


extension Notification.Name {
    static let loggedIn = NSNotification.Name("LoggedIn")
}

extension NumberFormatter {
    static var basic: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.locale = Locale.current
        formatter.numberStyle = .decimal
        return formatter
    }
}
