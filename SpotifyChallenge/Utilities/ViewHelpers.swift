//
//  ViewHelpers.swift
//  SpotifyChallenge
//
//  Created by Daniel Carvajal on 09-12-22.
//

import SwiftUI


///  Make the view to take the available space and allows the use of Spacer inside Scrollview.
private struct ScrollViewExpandedModifier: ViewModifier {
    let showsIndicators: Bool
    func body(content: Content) -> some View {
        GeometryReader { proxy in
            ScrollView(showsIndicators: showsIndicators) {
                content
                    .frame(minHeight: proxy.size.height)
            }.frame(width: proxy.size.width)
        }
    }
}

extension View {
    func wrapInExpandibleScrollView(showsIndicators: Bool = true) -> some View {
        modifier(ScrollViewExpandedModifier(showsIndicators: showsIndicators))
    }
}
