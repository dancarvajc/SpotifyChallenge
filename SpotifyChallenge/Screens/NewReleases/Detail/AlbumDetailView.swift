//
//  AlbumDetailView.swift
//  SpotifyChallenge
//
//  Created by Daniel Carvajal on 08-12-22.
//

import SwiftUI
import NukeUI

struct AlbumDetailView: View {
    @ObservedObject var viewModel: NewReleasesViewModel
    let artist: Artist
    private let columns = [GridItem(alignment: .leading), GridItem(alignment: .leading)]
    
    var body: some View {
        content
            .onDisappear {
                viewModel.removeSelectedArtist()
            }
            .onAppear {
                Task {
                    await viewModel.fetchArtistInfo(artist.href)
                }
            }
    }
}

private extension AlbumDetailView {
    
    var content: some View {
        VStack(spacing: 30) {
            if viewModel.selectedArtist == nil {
                ProgressView()
            } else {
                artistImageView
                Group {
                    artistNameView
                    genreView
                    popularityView
                    followersView
                }.padding(.horizontal, 30)
            }
        }
        .padding(.bottom)
        .wrapInExpandibleScrollView()
        .edgesIgnoringSafeArea(.top)
    }
    
    var artistNameView: some View {
        Text(viewModel.selectedArtist?.name ?? "")
            .font(.largeTitle.bold())
    }
    
    var genreView: some View {
        VStack {
            Text("Genres")
                .font(.system(size: 30).bold())
                .frame(maxWidth: .infinity, alignment: .leading)
            LazyVGrid(columns: columns) {
                ForEach(viewModel.selectedArtist?.genres ?? ["No data"], id: \.self) { genre in
                    Text("* \(genre.capitalizingFirstLetter())")
                }
            }
        }.padding(.bottom)
    }
    
    var popularityView: some View {
        VStack {
            Text("Popularity")
                .font(.system(size: 30).bold())
                .frame(maxWidth: .infinity, alignment: .leading)
            Text("\(viewModel.selectedArtist?.popularityFormatted ?? "")")
                .frame(maxWidth: .infinity, alignment: .leading)
        }.padding(.bottom)
    }
    
    var followersView: some View {
        VStack {
            Text("Followers")
                .font(.system(size: 30).bold())
                .frame(maxWidth: .infinity, alignment: .leading)
            Text(viewModel.selectedArtist?.followers?.totalFormatted ?? "")
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
    
    var artistImageView: some View {
        LazyImage(url: URL(string: viewModel.selectedArtist?.images?.first?.url ?? ""))
            .frame(height: 300)
    }
}

struct AlbumDetailView_Previews: PreviewProvider {
    static var previews: some View {
        AlbumDetailView(viewModel: .init(), artist: .init(followers: .init(href: nil, total: 12212343), genres: ["Rock", "Punk"], href: "", id: "id", images: [], name: "Nombre", popularity: 100))
    }
}
