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
        guard let ball = gameEngine.mainBall else {
            return
        }

        if gameEngine.isSpookyBallActive && gameEngine.isMainBallOutOfBounds {
            SoundManager.shared.playSound(sound: .ghost)
            gameEngine.removeLitGameObjects()
            ball.physicsBody.setPosition(to: CGVector(dx: ball.physicsBody.position.dx, dy: 10), isMovable: true)
            gameEngine.setOffset(to: .zero)
            gameEngine.bucket.physicsBody.resetHitCount()
        }
    }
}
