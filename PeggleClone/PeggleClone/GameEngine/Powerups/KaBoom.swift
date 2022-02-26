//
//  KaBoom.swift
//  PeggleClone
//
//  Created by Sivayogasubramanian on 25/2/22.
//

import Foundation

class KaBoom: Powerup {
    static let explosionVelocityMultiplier = 90.0
    static let explosionRadius = 100.0

    func applyPowerup(hitPeg: PegGameObject, gameEngine: PeggleGameEngine) {
        guard let ball = gameEngine.mainBall else {
            return
        }
        guard hitPeg.physicsBody.hitCount <= 2 else {
            return
        }

        SoundManager.shared.playSound(sound: .explosion)
        hitPeg.physicsBody.incrementHitCount()
        let direction = (ball.physicsBody.position - hitPeg.physicsBody.position).normalize()
        ball.physicsBody.setVelocity(
            to: ball.physicsBody.velocity + direction * KaBoom.explosionVelocityMultiplier,
            isMovable: true
        )
        for peg in gameEngine.pegs where peg != hitPeg && !peg.isLit {
            if peg.physicsBody.position.distance(to: hitPeg.physicsBody.position) < KaBoom.explosionRadius {
                peg.physicsBody.incrementHitCount()
                if peg.color == .blue {
                    peg.powerup?.applyPowerup(hitPeg: peg, gameEngine: gameEngine)
                }
            }
        }
    }
}
