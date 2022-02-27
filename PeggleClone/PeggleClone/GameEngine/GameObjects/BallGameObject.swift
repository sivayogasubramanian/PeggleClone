//
//  BallGameObject.swift
//  PeggleClone
//
//  Created by Sivayogasubramanian on 5/2/22.
//

import Foundation
import CoreGraphics

class BallGameObject: CircularIntersector {
    private static let gameObjectType = GameObjectType.ball

    private(set) var physicsBody: CircularPhysicsBody
    private(set) var radius = Constants.ballRadius
    var diameter: Double {
        radius * 2
    }
    var center: CGVector {
        physicsBody.position
    }

    init(position: CGVector) {
        physicsBody = CircularPhysicsBody(
            gameObjectType: BallGameObject.gameObjectType,
            position: position,
            radius: radius,
            mass: Constants.ballMass
        )
    }

    init(position: CGVector, radius: Double) {
        physicsBody = CircularPhysicsBody(
            gameObjectType: BallGameObject.gameObjectType,
            position: position,
            radius: radius,
            mass: Constants.ballMass
        )
    }

    func setRadius(to radius: Double) {
        self.radius = radius
        physicsBody.setRadius(to: radius)
    }

    func setPosition(to position: CGVector) {
        physicsBody.setPosition(to: position, isMovable: true)
    }
}

extension BallGameObject: Equatable, Identifiable {
    static func == (lhs: BallGameObject, rhs: BallGameObject) -> Bool {
        lhs === rhs
    }
}
