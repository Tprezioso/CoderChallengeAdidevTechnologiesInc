//
//  DetailListView.swift
//  CodingExercise
//
//  Created by Thomas Prezioso Jr on 3/2/21.
//

import SwiftUI

struct DetailListView: View {
    let artists: [Result]
    @Binding var isShowingDetail: Bool
    
    var body: some View {
            VStack {
                List(artists, id: \.trackId) { artist in
                    
                    DetailListViewCell(artistName: artist.artistName, trackName: artist.trackName, releaseDate: String(artist.releaseDate.prefix(4)), primaryGenreName: artist.primaryGenreName, trackPrice: artist.trackPrice)
                    }
                    .overlay(Button {
                        isShowingDetail = false
                    } label: {
                        XDismissButton()
                    }, alignment: .topTrailing)
                .padding()
        }
    }
}
