//
//  ShapeShift.swift
//  PeggleClone
//
//  Created by Sivayogasubramanian on 27/2/22.
//

import Foundation

class ShapeShift: Powerup {
    func applyPowerup(hitPeg: PegGameObject, gameEngine: PeggleGameEngine) {
        guard hitPeg.physicsBody.hitCount <= 1 else {
            return
        }

        guard let ball = gameEngine.ball else {
            return
        }

        hitPeg.physicsBody.incrementHitCount()
        let newRadius = Double.random(in: Constants.ballMinRadius...Constants.ballMaxRadius)
        let direction = (ball.center - hitPeg.physicsBody.position).normalize()
        let newCenter = hitPeg.physicsBody.position + direction * (newRadius + hitPeg.radius)
        let newBall = BallGameObject(position: newCenter, radius: newRadius)

        guard gameEngine.board.isAnyObjectPresentThatOverlaps(ball: newBall) else {
            return
        }

        ball.setRadius(to: newRadius)
        ball.setPosition(to: newCenter)
        let manifold = Intersector.detectBetween(circle1: hitPeg.physicsBody, circle2: ball.physicsBody)
        CollisionResolver.resolveCollisions(
            body1: hitPeg.physicsBody,
            body2: ball.physicsBody,
            manifold: manifold
        )
        SoundManager.shared.playSound(sound: .shapeshift)
    }
}
