//
//  NewReleasesView.swift
//  SpotifyChallenge
//
//  Created by Daniel Carvajal on 08-12-22.
//

import SwiftUI

struct NewReleasesView: View {
    @StateObject private var viewModel = NewReleasesViewModel()
    private let columns = [GridItem(), GridItem()]
    
    var body: some View {
        NavigationView {
            content
                .navigationTitle("New Releases")
                .onReceive(NotificationCenter.default.publisher(for: .loggedIn)) { _ in
                    Task {
                        await viewModel.fetchAlbums()
                    }
                }
                .onAppear {
                    Task {
                        await viewModel.fetchAlbums()
                    }
                }
        }
    }
}

private extension NewReleasesView {
    
    @ViewBuilder
    var content: some View {
        if !viewModel.albums.isEmpty {
            gridView
        } else if viewModel.isLoading {
            ProgressView()
        } else {
            notLinkedAccountView
        }
    }
    
    var notLinkedAccountView: some View {
        VStack {
            Text("To get started you have to link your Spotify account.")
                .padding(.bottom)
            Button("Link account") {
                viewModel.presentAuthentication()
            }
        }
    }
    
    var gridView: some View {
        ScrollView {
            LazyVGrid(columns: columns) {
                ForEach(viewModel.albums) { album in
                    NavigationLink {
                        AlbumDetailView(viewModel: viewModel, artist: album.artists.first!)
                    } label: {
                        AlbumView(image: album.images.first?.url ?? "", title: album.name ?? "", subtitle: album.releaseDate)
                    }
                }
            }
        }
    }
}

struct NewReleasesView_Previews: PreviewProvider {
    static var previews: some View {
        NewReleasesView()
    }
}
