//
//  TrackView.swift
//  music-stats
//
//  Created by Sarah Chow on 2023-07-06.
//

import SwiftUI

struct TrackView: View {
    
    var index: Int
    var name: String
    var artists: [artist]
    var image: String
    
    var body: some View {

        HStack {
            Text(String(index))
            
            AsyncImage(url: URL(string: image)) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 50, height: 50)
            
            VStack(alignment: .leading){
                Text(name).font(.title3)
                Text(artists[0].name).font(.body)
                
            }
        }

    }
}

//struct TrackView_Previews: PreviewProvider {
//    static var previews: some View {
//        TrackView(name: "name", artists: [])
//    }
//}
