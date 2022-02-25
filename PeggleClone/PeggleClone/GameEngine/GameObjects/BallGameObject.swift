//
//  BallGameObject.swift
//  PeggleClone
//
//  Created by Sivayogasubramanian on 5/2/22.
//

import Foundation
import CoreGraphics

class BallGameObject {
    private static let gameObjectType = GameObjectType.ball

    private(set) var physicsBody: PhysicsBody
    private(set) var radius = Constants.ballRadius
    var diameter: Double {
        radius * 2
    }

    init(position: CGVector) {
        physicsBody = CircularPhysicsBody(
            gameObjectType: BallGameObject.gameObjectType,
            position: position,
            radius: radius,
            mass: PhysicsConstants.ballMass
        )
    }
}
