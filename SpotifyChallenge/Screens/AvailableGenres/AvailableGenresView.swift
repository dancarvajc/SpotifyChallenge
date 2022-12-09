//
//  AvailableGenresView.swift
//  SpotifyChallenge
//
//  Created by Daniel Carvajal on 08-12-22.
//

import SwiftUI

struct AvailableGenresView: View {
    @StateObject private var viewModel = AvailableGenresViewModel()
    var body: some View {
        NavigationView {
            content
                .navigationTitle("Available genres")
                .onAppear {
                    Task {
                        await viewModel.fetchGenres()
                    }
                }
        }
    }
}

private extension AvailableGenresView {
    
    @ViewBuilder
    var content: some View {
        if !viewModel.genres.isEmpty {
            listView
        } else if viewModel.isLoading {
            ProgressView()
        } else  {
            Text("No genres available")
        }
    }
    
    var listView: some View {
        List(viewModel.genres, id: \.self) { genre in
            Text(genre)
                .font(.title.italic())
        }
    }
}

struct AvailableGenresView_Previews: PreviewProvider {
    static var previews: some View {
        AvailableGenresView()
    }
}
