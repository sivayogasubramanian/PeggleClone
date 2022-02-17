//
//  BallGameObject.swift
//  PeggleClone
//
//  Created by Sivayogasubramanian on 5/2/22.
//

import Foundation
import CoreGraphics

class BallGameObject: CircularPhysicsBody {
    static let radius = CGFloat(20)
    static let diameter = radius * 2
    private static let ballGameObjectType = GameObjectType.ball

    init(position: CGVector) {
        super.init(
            gameObjectType: BallGameObject.ballGameObjectType,
            position: position,
            radius: BallGameObject.radius,
            mass: PhysicsConstants.ballMass
        )
    }
}
