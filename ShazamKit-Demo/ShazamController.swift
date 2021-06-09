//
//  ShazamController.swift
//  ShazamKit-Demo
//
//  Created by Aaryan Kothari on 09/06/21.
//

import SwiftUI
import ShazamKit

class ShazamController: NSObject, ObservableObject {
    
    @Published var media : [SHMatchedMediaItem] = []
    @Published var favourites : [SHMatchedMediaItem] = []
    
    private let audioEngine = AVAudioEngine()
    private let signatureGenerator = SHSignatureGenerator()
    private let session = SHSession()
    private let audioSession = AVAudioSession.sharedInstance()

    
    override init() {
        super.init()
        initialSetup()
    }
    
    func initialSetup() {
        self.session.delegate = self
        self.audioSession.requestRecordPermission { _ in }
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
        }
        
        self.audioEngine.prepare()
        try! self.audioEngine.start()
        print("LISTENING")
    }
    
    func session(_ session: SHSession, didFind match: SHMatch) {
        guard let song = match.mediaItems.first else { return }
        print("SONG FOUND: \(song.title ?? "NO TITLE")")
        self.media.append(song)
        self.audioEngine.stop()
    }
    
    func session(_ session: SHSession, didNotFindMatchFor signature: SHSignature, error: Error?) {
        print("SESSION DID NOT MATCH: \(error?.localizedDescription ?? "ERROR")")
    }
}
