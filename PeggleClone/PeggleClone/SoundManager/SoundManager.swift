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

}

class SoundManager {
    static let shared = SoundManager()

    var players: [Sound: AVAudioPlayer] = [:]

    private init() {
        for sound in Sound.allCases {
            if let path = Bundle.main.path(forResource: sound.rawValue, ofType: "wav") {
                let player = try? AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
                players[sound] = player
            }
        }
    }

    func playSound(sound: Sound, isReducedVolume: Bool = false) {
        if let player = players[sound] {
            guard !player.isPlaying else {
                return
            }
            player.volume = isReducedVolume ? 2 : 4
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
