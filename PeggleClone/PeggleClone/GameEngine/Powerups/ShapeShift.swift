//
//  ShapeShift.swift
//  PeggleClone
//
//  Created by Sivayogasubramanian on 27/2/22.
//

class ShapeShift: Powerup {
    func applyPowerup(hitPeg: PegGameObject, gameEngine: PeggleGameEngine) {
        guard hitPeg.physicsBody.isHitForTheFirstTime else {
            return
        }
        guard let ball = gameEngine.mainBall else {
            return
        }
        hitPeg.physicsBody.incrementHitCount()

        let newRadius = Double.random(in: Constants.ballMinRadius...Constants.ballMaxRadius)
        ball.setRadius(to: newRadius)

        // Resolve collisions for ball with changed radius
        let manifold = Intersector.detectBetween(circle1: hitPeg.physicsBody, circle2: ball.physicsBody)
        CollisionResolver.resolveCollisions(body1: hitPeg.physicsBody, body2: ball.physicsBody, manifold: manifold)

        SoundManager.shared.playSound(sound: .shapeshift)
    }
}
