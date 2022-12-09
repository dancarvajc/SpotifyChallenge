//
//  TabView.swift
//  SpotifyChallenge
//
//  Created by Daniel Carvajal on 06-12-22.
//

import SwiftUI

struct TabComponentView: View {
    @State private var tab: Tab = .newReleases
    
    var body: some View {
        TabView(selection: $tab) {
            NewReleasesView()
                .tabItem {
                    Text("New releases")
                    Image(systemName: "music.note.house")
                }
                .tag(Tab.newReleases)
            AvailableGenresView()
                .tabItem {
                    Text("Genres")
                    Image(systemName: "music.quarternote.3")
                }
                .tag(Tab.genres)
            DebugView()
                .tabItem {
                    Text("Debug")
                    Image(systemName: "star")
                }
                .tag(Tab.debug)
        }
    }
}

enum Tab {
    case newReleases, genres, debug
}


struct TabView_Previews: PreviewProvider {
    static var previews: some View {
        TabComponentView()
    }
}
