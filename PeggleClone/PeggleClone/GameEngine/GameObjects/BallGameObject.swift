//
//  BallGameObject.swift
//  PeggleClone
//
//  Created by Sivayogasubramanian on 5/2/22.
//

import Foundation
import CoreGraphics

class BallGameObject {
    private static let ballGameObjectType = GameObjectType.ball

    private(set) var physicsBody: PhysicsBody
    private(set) var radius = Constants.ballRadius
    var diameter: Double {
        radius * 2
    }

    init(position: CGVector) {
        physicsBody = CircularPhysicsBody(
            gameObjectType: BallGameObject.ballGameObjectType,
            position: position,
            radius: radius,
            mass: PhysicsConstants.ballMass
        )
    }
}
