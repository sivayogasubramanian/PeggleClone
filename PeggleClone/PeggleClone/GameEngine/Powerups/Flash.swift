//
//  Flash.swift
//  PeggleClone
//
//  Created by Sivayogasubramanian on 27/2/22.
//

import Foundation

class Flash: Powerup {
    func applyPowerup(hitPeg: PegGameObject, gameEngine: PeggleGameEngine) {
        guard let ball = gameEngine.mainBall else {
            return
        }

        guard hitPeg.physicsBody.hitCount <= 1 else {
            return
        }

        hitPeg.physicsBody.incrementHitCount()
        let velocity = ball.physicsBody.velocity

        guard velocity.length() < 1000 else {
            return
        }

        ball.physicsBody.setVelocity(to: velocity * 2, isMovable: true)
        SoundManager.shared.playSound(sound: .flash)
    }
}
