//
//  ShazamController.swift
//  ShazamKit-Demo
//
//  Created by Aaryan Kothari on 09/06/21.
//

import SwiftUI
import ShazamKit

class ShazamController: NSObject, ObservableObject {
    
    @Published var media : [SHMatchedMediaItem] = SHMatchedMediaItem.data
    @Published var buttonTitle = "Listen"
    @Published var state: ShazamState = .idle
    private let audioEngine = AVAudioEngine()
    private let signatureGenerator = SHSignatureGenerator()
    private let session = SHSession()
    private let audioSession = AVAudioSession.sharedInstance()

    
    @Published var searchText: String = "" {
        didSet {
            if searchText.isEmpty {
                searchResults = media
            } else {
                searchResults = media.filter { $0.title?.contains(searchText) ??  false }
            }
        }
    }
    
    @Published var searchResults: [SHMatchedMediaItem] = SHMatchedMediaItem.data
    
    override init() {
        super.init()
        initialSetup()
    }
    
    func initialSetup() {
        self.session.delegate = self
        self.audioSession.requestRecordPermission { _ in }
    }
    
    func delete(_ song: SHMatchedMediaItem) {
        self.media.removeAll(where: {$0.title == song.title} )
        self.searchResults.removeAll(where: {$0.title == song.title} )
    }
    
    func star(_ song: SHMatchedMediaItem){
        
    }
    
}

extension ShazamController: SHSessionDelegate {
    
    func listen() {
        try! audioSession.setActive(true, options: .notifyOthersOnDeactivation)
        let inputNode = self.audioEngine.inputNode
        let recordingFormat = inputNode.outputFormat(forBus: 0)
        
        inputNode.removeTap(onBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer: AVAudioPCMBuffer, when: AVAudioTime) in
            try! self.signatureGenerator.append(buffer, at: nil)
            self.session.matchStreamingBuffer(buffer, at: nil)
            
            DispatchQueue.main.async {
                self.searchResults = SHMatchedMediaItem.data
                self.media = SHMatchedMediaItem.data
            }
        }
        
        self.audioEngine.prepare()
        try! self.audioEngine.start()
        self.buttonTitle = "Listening"
    }
    
    func session(_ session: SHSession, didFind match: SHMatch) {
        guard let song = match.mediaItems.first else { return }
        print("SONG FOUND: \(song.title ?? "NO TITLE")")
        self.audioEngine.stop()
        DispatchQueue.main.async {
        self.buttonTitle = "Listen"
            self.media.append(song)
        }
    }
    
    func session(_ session: SHSession, didNotFindMatchFor signature: SHSignature, error: Error?) {
        print("SESSION DID NOT MATCH: \(error?.localizedDescription ?? "ERROR")")
    }
}

extension SHMatchedMediaItem {
    static let data = [SHMatchedMediaItem(properties: [.title:"good 4 u",.artist:"Olivia Rodrigo",.artworkURL:URL(string: "https://is3-ssl.mzstatic.com/image/thumb/Music125/v4/33/fd/32/33fd32b1-0e43-9b4a-8ed6-19643f23544e/21UMGIM26092.rgb.jpg/400x400cc.jpg")]),
                       SHMatchedMediaItem(properties: [.title:"Talking To The Moon",.artist:"Bruno Mars",.artworkURL:URL(string: "https://is5-ssl.mzstatic.com/image/thumb/Music115/v4/25/6d/95/256d95ea-c58c-074d-b6f1-18f5cb4e6b96/075679956293.jpg/400x400cc.jpg")]),
                       SHMatchedMediaItem(properties: [.title:"Jalebi Baby",.artist:"Tesher",.artworkURL:URL(string: "https://is4-ssl.mzstatic.com/image/thumb/Music114/v4/0a/11/49/0a1149fc-1a88-8869-9603-d488585265db/21UMGIM30101.rgb.jpg/400x400cc.jpg")]),
                        SHMatchedMediaItem(properties: [.title:"Idfc",.artist:"Blackbear",.artworkURL:URL(string: "https://is1-ssl.mzstatic.com/image/thumb/Music3/v4/11/df/b4/11dfb4e8-eac5-9b32-ae0b-ed883fed56ca/blackbear-dead-roses.jpg/400x400cc.jpg")])
    ]
}
