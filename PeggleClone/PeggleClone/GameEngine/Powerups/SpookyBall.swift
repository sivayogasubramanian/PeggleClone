//
//  SpookyBall.swift
//  PeggleClone
//
//  Created by Sivayogasubramanian on 25/2/22.
//

import Foundation
import CoreGraphics

class SpookyBall: Powerup {
    func applyPowerup(hitPeg: PegGameObject, gameEngine: PeggleGameEngine) {
        guard let ball = gameEngine.ball else {
            return
        }

        if gameEngine.isSpookyBallActive && gameEngine.isBallOutOfBounds {
            gameEngine.removeLitGameObjects()
            ball.physicsBody.setPosition(to: CGVector(dx: ball.physicsBody.position.dx, dy: 10), isMovable: true)
            gameEngine.bucket.physicsBody.resetHitCount()
        }
    }
}
