//
//  PegGameObject.swift
//  PeggleClone
//
//  Created by Sivayogasubramanian on 5/2/22.
//

import Foundation
import CoreGraphics

class PegGameObject {
    private static let pegGameObjectType = GameObjectType.peg

    private(set) var physicsBody: PhysicsBody
    private(set) var radius: Double
    private(set) var color: PeggleColor
    var diameter: Double {
        radius * 2
    }
    var isHit: Bool {
        physicsBody.hitCount != 0
    }
    var shouldBeRemoved: Bool {
        physicsBody.hitCount > PhysicsConstants.physicsBodyMaxHitCount
    }

    init(fromPeg: Peg) {
        radius = fromPeg.radius
        color = fromPeg.color
        physicsBody = CircularPhysicsBody(
            gameObjectType: PegGameObject.pegGameObjectType,
            position: fromPeg.center,
            radius: fromPeg.radius
        )
    }
}

extension PegGameObject: Equatable, Identifiable {
    static func == (lhs: PegGameObject, rhs: PegGameObject) -> Bool {
        lhs === rhs
    }
}
