//
//  AlbumView.swift
//  SpotifyChallenge
//
//  Created by Daniel Carvajal on 08-12-22.
//

import SwiftUI
import NukeUI

struct AlbumView: View {
    let image: String
    let title: String
    let subtitle: String
    var body: some View {
        VStack {
            Spacer()
            LazyImage(url: URL(string: image))
                .cornerRadius(20)
                .frame(height: 200)
            Text(title)
                .font(.system(size: 16).bold())
                .foregroundColor(Color(.label))
            
            Text(subtitle)
                .font(.system(size: 13).italic())
                .foregroundColor(Color(.label))
            Spacer()
        }
        .padding()
        .frame(height: 300)
    }
}

struct AlbumView_Previews: PreviewProvider {
    static var previews: some View {
        AlbumView(image: "https://www.mpalalive.org/uploads/gallery/clawless-otter_gallery_1.jpg", title: "Titulo", subtitle: "Subtitulo")
    }
}
