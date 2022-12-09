//
//  DebugView.swift
//  SpotifyChallenge
//
//  Created by Daniel Carvajal on 09-12-22.
//

import SwiftUI

struct DebugView: View {
    @State private var keychainManager = KeychainManager()
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Button("Remove tokens from Keychain") {
                try? keychainManager.removeAll()
            }
            Text("This way you can link your account again.")
                .font(.caption)
        }
    }
}
