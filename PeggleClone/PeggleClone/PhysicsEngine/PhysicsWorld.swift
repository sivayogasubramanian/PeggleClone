//
//  PhysicsWorld.swift
//  PeggleClone
//
//  Created by Sivayogasubramanian on 4/2/22.
//

import CoreGraphics
import Foundation

class PhysicsWorld {
    private(set) var physicsBodies: [PhysicsBody] = []

    func addPhysicsBody(_ physicsBody: PhysicsBody) {
        physicsBodies.append(physicsBody)
    }

    func removePhysicsBody(_ physicsBody: PhysicsBody) {
        physicsBodies.removeAll(where: { $0 === physicsBody })
    }

    func updatePhysicsBodiesPositions(dt deltaTime: TimeInterval) {
        physicsBodies.forEach({ $0.updatePhysicsBody(dt: deltaTime, isMovable: $0.isMovable) })
    }

    func resolveCollisions() {
        guard !physicsBodies.isEmpty else {
            return
        }

        for iIndex in 0..<physicsBodies.count - 1 {
            for jIndex in iIndex + 1..<physicsBodies.count {
                let body1 = physicsBodies[iIndex], body2 = physicsBodies[jIndex]
                resolveCollisionsOfPhysicsBodies(body1, body2)
            }
        }
    }

    private func resolveCollisionsOfPhysicsBodies(_ body1: PhysicsBody, _ body2: PhysicsBody) {
        guard GameObjects.areCollidable(body1.gameObjectType, body2.gameObjectType) else {
            return
        }

        let manifold = IntersectionDetector.detectCollisions(body1: body1, body2: body2)
        guard manifold.hasCollided else {
            return
        }

        body1.incrementHitCount()
        body2.incrementHitCount()
        CollisionResolver.resolveCollisions(body1: body1, body2: body2, manifold: manifold)
    }
}
