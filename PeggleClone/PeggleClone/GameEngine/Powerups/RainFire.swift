//
//  RainFire.swift
//  PeggleClone
//
//  Created by Sivayogasubramanian on 27/2/22.
//

import Foundation
import CoreGraphics

class RainFire: Powerup {
    func applyPowerup(hitPeg: PegGameObject, gameEngine: PeggleGameEngine) {
        guard hitPeg.physicsBody.isHitForTheFirstTime else {
            return
        }
        guard gameEngine.balls.isEmpty else {
            return
        }
        hitPeg.physicsBody.incrementHitCount()

        // Create new helper balls
        let xStep = gameEngine.board.boardSize.width / Double(Constants.xRatio)
        let ball1 = BallGameObject(position: CGVector(dx: 2 * xStep, dy: 0))
        let ball2 = BallGameObject(position: CGVector(dx: 3 * xStep, dy: 0))
        let ball3 = BallGameObject(position: CGVector(dx: 4 * xStep, dy: 0))
        let ball4 = BallGameObject(position: CGVector(dx: 5 * xStep, dy: 0))

        // Set force to gravity
        ball1.physicsBody.setForce(to: Constants.gravity, isMovable: true)
        ball2.physicsBody.setForce(to: Constants.gravity, isMovable: true)
        ball3.physicsBody.setForce(to: Constants.gravity, isMovable: true)
        ball4.physicsBody.setForce(to: Constants.gravity, isMovable: true)

        // Add to game engine
        gameEngine.addExtraBall(ball1)
        gameEngine.addExtraBall(ball2)
        gameEngine.addExtraBall(ball3)
        gameEngine.addExtraBall(ball4)

        SoundManager.shared.playSound(sound: .fire)
    }
}
