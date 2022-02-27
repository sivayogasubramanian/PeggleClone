//
//  KaBoom.swift
//  PeggleClone
//
//  Created by Sivayogasubramanian on 25/2/22.
//

import Foundation

class KaBoom: Powerup {
    static let explosionRadius = 100.0

    func applyPowerup(hitPeg: PegGameObject, gameEngine: PeggleGameEngine) {
        guard let ball = gameEngine.mainBall else {
            return
        }
        guard hitPeg.physicsBody.isHitForTheFirstTime else {
            return
        }
        hitPeg.physicsBody.incrementHitCount()

        // Increase velocity due to explosion
        if ball.physicsBody.velocity.length() < Constants.initialBallLaunchVelocity {
            ball.physicsBody.setVelocity(
                to: ball.physicsBody.velocity.normalize() * (Constants.initialBallLaunchVelocity * 2),
                isMovable: true
            )
        }

        // Chain reaction
        for peg in gameEngine.pegs where peg != hitPeg && !peg.isLit {
            if peg.physicsBody.position.distance(to: hitPeg.physicsBody.position) < KaBoom.explosionRadius {
                peg.physicsBody.incrementHitCount()
                PowerupMapping
                    .getPowerupFor(color: peg.color)?.applyPowerup(hitPeg: peg, gameEngine: gameEngine)
            }
        }

        SoundManager.shared.playSound(sound: .explosion)
    }
}
