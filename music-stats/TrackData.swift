//
//  Decoder.swift
//  music-stats
//
//  Created by Sarah Chow on 2023-06-13.
//

import Foundation

struct artist: Codable {
    let name: String
}

struct image: Codable {
    let url: String
}

struct album: Codable {
    let images: [image]
}

struct track: Codable, Identifiable, Hashable {
    
    let artists: [artist]
    let name: String
    let id: String
    let album: album
    
    static func == (lhs: track, rhs: track) -> Bool {
        lhs.id == rhs.id
    }
    
    public func hash(into hasher: inout Hasher) {
        return hasher.combine(id)
    }
}

struct totalTracks: Codable {
    let items: [track]
}

