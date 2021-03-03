//
//  ContentView.swift
//  CodingExercise
//
//  Created by Thomas Prezioso Jr on 3/2/21.
//

import SwiftUI

struct SearchForArtist: View {
    @State var searchArtist = ""
    @State private var results = [Result]()
    @State var isDetailListShown = false
    @State var isLoading = false
    @State var thereIsAnError = false
//    @StateObject var viewModel = SearchForArtistViewModel()
    
    var body: some View {
        ZStack {
            NavigationView {
                VStack(spacing: 50) {
                    TextField("Search for an Artist", text: $searchArtist)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    Button {
                        loadData()
                        searchArtist = ""

                    } label: {
                        Text("Search")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .frame(width: 260, height: 50)
                            .foregroundColor(.white)
                            .background(Color.green)
                            .cornerRadius(10)
                    }.alert(isPresented: $thereIsAnError) {
                        Alert(title: Text("Important message"), message: Text("There was an error with your search. Please try again"), dismissButton: .default(Text("OK")))
                    }
                Spacer()
                }.navigationTitle("Artist Search")
                .padding()
                .padding(.top, 100)
            }
            
            if isDetailListShown {
                DetailListView(artists: results, isShowingDetail: $isDetailListShown)
            }
            
            if isLoading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .gray))
                    .scaleEffect(2, anchor: .center)
            }
        }
    
    }
    
     func loadData() {
        isLoading = true
        let query = searchArtist.lowercased()
        let queryAltered = query.replacingOccurrences(of: " ", with: "+")
        print(queryAltered)
        guard let url = URL(string: "https://itunes.apple.com/search?term=\(queryAltered)") else {
            print("Invalid URL")
            return
        }
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                if let decodedResponse = try? JSONDecoder().decode(Response.self, from: data) {
                    DispatchQueue.main.async {
                        isLoading = false
                        isDetailListShown = true
                        self.results = decodedResponse.results
                        print(self.results)
                    }
                    return
                }
            }

            isLoading = false
            thereIsAnError = true
                
            print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
        }.resume()
    }
}

struct Response: Codable {
    var results: [Result]
}

struct Result: Codable {
    var trackId: Int
    let artistName: String
    let trackName: String
    let releaseDate: String
    let primaryGenreName: String
    let trackPrice: Double

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SearchForArtist()
    }
}
