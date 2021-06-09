//
//  Media.swift
//  ShazamKit-Demo
//
//  Created by Aaryan Kothari on 09/06/21.
//

import Foundation
import ShazamKit

struct SHMedia {
    
    let name: String
    let artist: String
    let image: URL?
    let mediaUrl: URL
    
    init(media: SHMatchedMediaItem) {
        self.name = media.title ?? ""
        self.artist = media.artist ?? ""
        self.image = media.artworkURL
        self.mediaUrl = media.appleMusicURL ?? URL(string: "https://www.apple.com/in/apple-music/")!
    }
    
    internal init(name: String?, artist: String?, image: URL?) {
        self.name = name ?? ""
        self.artist = artist ?? ""
        self.image = image
        self.mediaUrl = URL(string: "https://www.apple.com/in/apple-music/")!
    }
    
    static let data = SHMedia(name: "Astronaut In The Ocean", artist: "Masked Wolf", image: URL(string: "https://is2-ssl.mzstatic.com/image/thumb/Music115/v4/83/eb/59/83eb59d9-629d-5f60-7a6b-a2cb0b70ebd1/075679793102.jpg/400x400cc.jpg"))
}
