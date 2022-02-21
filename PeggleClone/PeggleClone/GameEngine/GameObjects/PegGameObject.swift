//
//  PegGameObject.swift
//  PeggleClone
//
//  Created by Sivayogasubramanian on 5/2/22.
//

import Foundation
import CoreGraphics

class PegGameObject: CircularPhysicsBody {
    private static let pegGameObjectType = GameObjectType.peg

    private(set) var color: PeggleColor
    var isHit: Bool {
        super.hitCount != 0
    }
    var shouldBeRemoved: Bool {
        super.hitCount > PhysicsConstants.physicsBodyMaxHitCount
    }

    init(fromPeg: Peg) {
        color = fromPeg.color
        super.init(
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
