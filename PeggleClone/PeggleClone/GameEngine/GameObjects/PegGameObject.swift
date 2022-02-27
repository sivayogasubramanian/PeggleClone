//
//  PegGameObject.swift
//  PeggleClone
//
//  Created by Sivayogasubramanian on 5/2/22.
//

import Foundation
import CoreGraphics

class PegGameObject {
    private static let gameObjectType = GameObjectType.peg

    private(set) var physicsBody: CircularPhysicsBody
    private(set) var radius: Double
    private(set) var color: PeggleColor
    private(set) var rotation: Double
    private(set) var powerup: Powerup?
    var diameter: Double {
        radius * 2
    }
    var isLit: Bool {
        physicsBody.hitCount != 0
    }
    var shouldBeRemoved: Bool {
        physicsBody.hitCount > Constants.physicsBodyMaxHitCount
    }

    init(fromPeg peg: Peg) {
        radius = peg.radius
        color = peg.color
        rotation = peg.rotation
        powerup = PowerupMapping.getPowerupFor(color: peg.color)
        physicsBody = CircularPhysicsBody(
            gameObjectType: PegGameObject.gameObjectType,
            position: peg.center,
            radius: peg.radius
        )
    }
}

extension PegGameObject: Equatable, Identifiable {
    static func == (lhs: PegGameObject, rhs: PegGameObject) -> Bool {
        lhs === rhs
    }
}
