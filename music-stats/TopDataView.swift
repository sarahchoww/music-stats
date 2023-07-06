//
//  TopDataViewController.swift
//  music-stats
//
//  Created by Sarah Chow on 2023-06-25.
//

import SwiftUI



struct TopDataView: View {
    weak var navigationController: UINavigationController?
    var spotifyAccessToken: String
    var topTrackArr: [track]
    
    // To modify variables in a struct
//   @State var topTrackArr = [track]()
    
    init(navigationController: UINavigationController? = nil, spotifyAccessToken: String = "", topTrackArr: [track] = []) {
        self.navigationController = navigationController
        self.spotifyAccessToken = spotifyAccessToken
        self.topTrackArr = topTrackArr
//        fetchTopArtists()
    }
    
    func fetchTopArtists() -> Void {
        
        let url: String = "https://api.spotify.com/v1/me/top/tracks"
        
        var components = URLComponents(string: url)!
        
        components.queryItems = [
            URLQueryItem(name: "time_range", value: "long_term"),
            URLQueryItem(name: "limit", value: "5"),
            URLQueryItem(name: "offset", value: "0")
        ]
    
        var request = URLRequest(url: components.url!)
        let spotifyAuthorization = "Bearer \(spotifyAccessToken)"

        
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(spotifyAuthorization, forHTTPHeaderField: "Authorization")

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data,                              // is there data
                  let response = response as? HTTPURLResponse,  // is there HTTP response
                  200 ..< 300 ~= response.statusCode,
                  error == nil else {                           // was there no error, otherwise ...
                      print("Error fetching top tracks \(error?.localizedDescription ?? "")")
                    return
                  }
            _ = try? JSONSerialization.jsonObject(with: data) as? [String: Any]
            let responseDecode: totalTracks = try! JSONDecoder().decode(totalTracks.self, from: data)
            
            for i in 0...4 {
                let trackResponse = responseDecode.items as [track]
                let artistResponse = trackResponse[i].artists as [artist]
                
                print("decoded= ", i, trackResponse[i].name, artistResponse)
                
//                topTrackArr.append(contentsOf: trackResponse)
            }
            

            
        }
        task.resume()
    }

    var body: some View {
        
        VStack(alignment: .center){


            Button("Get top tracks"){
                print("tapped")
            }
            
            Spacer()
            Text("Top Tracks")
            List {
                ForEach(topTrackArr) { track in
                    Text(track.name)
                }
            }
            Spacer()
         }
        
    }
}

