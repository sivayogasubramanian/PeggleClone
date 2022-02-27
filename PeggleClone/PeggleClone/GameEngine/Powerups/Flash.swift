//
//  Flash.swift
//  PeggleClone
//
//  Created by Sivayogasubramanian on 27/2/22.
//

class Flash: Powerup {
    func applyPowerup(hitPeg: PegGameObject, gameEngine: PeggleGameEngine) {
        guard hitPeg.physicsBody.isHitForTheFirstTime else {
            return
        }
        guard let ball = gameEngine.mainBall else {
            return
        }

        hitPeg.physicsBody.incrementHitCount()
        let velocity = ball.physicsBody.velocity

        // Prevent ball from going too fast
        guard velocity.length() < Constants.initialBallLaunchVelocity else {
            return
        }

        ball.physicsBody.setVelocity(to: velocity * 2, isMovable: true)
        SoundManager.shared.playSound(sound: .flash)
    }
}
