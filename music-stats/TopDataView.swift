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
    
    init(navigationController: UINavigationController? = nil, spotifyAccessToken: String = "", topTrackArr: [track] = []) {
        self.navigationController = navigationController
        self.spotifyAccessToken = spotifyAccessToken
        self.topTrackArr = topTrackArr
    }

    var body: some View {
        
        VStack(alignment: .center){
            
            Text("Top Tracks")
            List {
                ForEach(Array(zip(topTrackArr.indices, topTrackArr)), id: \.0) { index, track in
                    TrackView(index: index + 1, name: track.name, artists: track.artists, image: track.album.images[2].url)
                }
            }
            Spacer()
         }
        
    }
}
