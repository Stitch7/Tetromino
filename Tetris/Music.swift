//
//  Music.swift
//  Tetris
//
//  Created by Christopher Reitz on 14/11/2016.
//  Copyright © 2016 Christopher Reitz. All rights reserved.
//

import Foundation
import AVFoundation

enum Music {
    case original
    case acapella
    case techno
    case dubstep
    case dance
    case orchestra
}

extension Music {
    var audioFile: URL {
        switch self {
        case .original:
            return URL(fileURLWithPath: Bundle.main.path(forResource: "djrush", ofType: "mp3")!)
        case .acapella:
            return URL(fileURLWithPath: Bundle.main.path(forResource: "djrush", ofType: "mp3")!)
        case .techno:
            return URL(fileURLWithPath: Bundle.main.path(forResource: "djrush", ofType: "mp3")!)
        case .dubstep:
            return URL(fileURLWithPath: Bundle.main.path(forResource: "djrush", ofType: "mp3")!)
        case .dance:
            return URL(fileURLWithPath: Bundle.main.path(forResource: "djrush", ofType: "mp3")!)
        case .orchestra:
            return URL(fileURLWithPath: Bundle.main.path(forResource: "djrush", ofType: "mp3")!)
        }
    }
}

final class MusicPlayer {
    var music: Music
    private var audioPlayer = AVAudioPlayer()

    init(music: Music) {
        self.music = music
    }

    func play() {
        audioPlayer = try! AVAudioPlayer(contentsOf: music.audioFile)
        audioPlayer.prepareToPlay()
        audioPlayer.play()
    }
}
