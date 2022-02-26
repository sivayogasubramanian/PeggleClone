//
//  SoundManager.swift
//  PeggleClone
//
//  Created by Sivayogasubramanian on 26/2/22.
//

import AVFoundation

enum Sound: String, CaseIterable {
    case main
    case game
    case click
    case click2
    case shoot
    case hitPeg
    case hitBlock
    case hitBucket
    case win
    case lose
    case explosion
    case ghost
    case shapeshift
    case flash
}

class SoundManager {
    static let shared = SoundManager()

    private var players: [Sound: AVAudioPlayer] = [:]

    private init() {
        for sound in Sound.allCases {
            if let path = Bundle.main.path(forResource: sound.rawValue, ofType: "wav") {
                let player = try? AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
                players[sound] = player
            }
        }
    }

    func playSound(sound: Sound, isReducedVolume: Bool = false, isLooped: Bool = false) {
        if let player = players[sound] {
            guard !player.isPlaying else {
                return
            }
            player.numberOfLoops = isLooped ? 10 : 0
            player.volume = isReducedVolume ? 1 : 2
            player.play()
        }
    }

    func stopSound(sound: Sound) {
        if let player = players[sound] {
            guard player.isPlaying else {
                return
            }
            player.stop()
        }
    }
}
