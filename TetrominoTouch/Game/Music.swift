//
//  Music.swift
//  TetrominoTouch
//
//  Created by Christopher Reitz on 14/11/2016.
//  Copyright © 2016 Christopher Reitz. All rights reserved.
//

import Foundation.NSURL
import AVFoundation.AVFAudio

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
            return url(forResource: "djrush")
        case .acapella:
            return url(forResource: "djrush")
        case .techno:
            return url(forResource: "djrush")
        case .dubstep:
            return url(forResource: "djrush")
        case .dance:
            return url(forResource: "djrush")
        case .orchestra:
            return url(forResource: "djrush")
        }
    }

    private func url(forResource resource: String) -> URL {
        return URL(fileURLWithPath: Bundle.main.path(forResource: resource, ofType: "mp3")!)
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
