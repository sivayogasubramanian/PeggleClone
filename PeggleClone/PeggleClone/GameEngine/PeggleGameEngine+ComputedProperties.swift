//
//  PeggleGameEngine+ComputedProperties.swift
//  PeggleClone
//
//  Created by Sivayogasubramanian on 27/2/22.
//

import Foundation

extension PeggleGameEngine {
    var isReadyToShoot: Bool {
        mainBall == nil
    }
    var isSpookyBallActive: Bool {
        pegs.contains(where: { $0.isLit && $0.color == .purple })
    }
    var isMainBallOutOfBounds: Bool {
        guard let ball = mainBall else {
            return false
        }

        return ball.physicsBody.position.dy > max(board.maxHeight, boardSize.height - ball.radius)
    }
    var shouldRemoveMainBall: Bool {
        isMainBallOutOfBounds || (!isSpookyBallActive && bucket.isHit)
    }
    var isGameOver: Bool {
        numberOfBallsLeft <= 0
    }
    var isGameWon: Bool {
        !pegs.contains(where: { $0.color == .orange })
    }
    var numberOfOrangePegsLeft: Int {
        pegs.filter({ $0.color == .orange }).count
    }
    var numberOfBluePegsLeft: Int {
        pegs.filter({ $0.color == .blue }).count
    }
    var numberOfPurplePegsLeft: Int {
        pegs.filter({ $0.color == .purple }).count
    }
    var numberOfGrayPegsLeft: Int {
        pegs.filter({ $0.color == .gray }).count
    }
    var numberOfYellowPegsLeft: Int {
        pegs.filter({ $0.color == .yellow }).count
    }
    var numberOfPinkPegsLeft: Int {
        pegs.filter({ $0.color == .pink }).count
    }
}
