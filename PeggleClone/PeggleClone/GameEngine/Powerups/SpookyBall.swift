//
//  SpookyBall.swift
//  PeggleClone
//
//  Created by Sivayogasubramanian on 25/2/22.
//

import CoreGraphics

class SpookyBall: Powerup {
    func applyPowerup(hitPeg: PegGameObject, gameEngine: PeggleGameEngine) {
        guard let ball = gameEngine.mainBall else {
            return
        }

        if gameEngine.isSpookyBallActive && gameEngine.isMainBallOutOfBounds {
            // Create the spooky ball
            let position = CGVector(dx: ball.physicsBody.position.dx, dy: 0)
            let newBall = BallGameObject(position: position)
            newBall.physicsBody.setForce(to: ball.physicsBody.force, isMovable: true)
            newBall.physicsBody.setVelocity(to: ball.physicsBody.velocity, isMovable: true)

            // Remove old ball
            gameEngine.removeBallIfBallExited()

            // Add spooky ball to game engine
            gameEngine.setMainBall(to: newBall)
            gameEngine.world.addPhysicsBody(newBall.physicsBody)

            SoundManager.shared.playSound(sound: .ghost)
        }
    }
}
