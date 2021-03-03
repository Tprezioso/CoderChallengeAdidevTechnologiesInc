//
//  DetailListViewCell.swift
//  CodingExercise
//
//  Created by Thomas Prezioso Jr on 3/2/21.
//

import SwiftUI

struct DetailListViewCell: View {
    var artistName: String
    var trackName: String
    var releaseDate: String
    var primaryGenreName: String
    var trackPrice: Double
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("\(artistName)")
                .font(.title)
            Text("Track Name: \(trackName)")
                .font(.title2)
            Text("$ \(String(format: "%.2f", trackPrice))")
            Text("Release Date: \(releaseDate)")
                .font(.subheadline)
            Text("Genre: \(primaryGenreName)")
                .font(.subheadline)
            
        }
    }
}

struct DetailListViewCell_Previews: PreviewProvider {
    static var previews: some View {
        DetailListViewCell(artistName: "Taylor Swift", trackName: "Shake it off", releaseDate: "2017", primaryGenreName: "Pop", trackPrice: 1.29)
    }
}
