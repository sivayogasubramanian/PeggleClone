//
//  CollisionResolver.swift
//  PeggleClone
//
//  Created by Sivayogasubramanian on 5/2/22.
//

import Foundation
import CoreGraphics

class CollisionResolver {
    static func resolveCollisions(body1: PhysicsBody, body2: PhysicsBody, manifold: CollisionManifold) {
        let impulseVector = getImpulseVector(body1: body1, body2: body2, manifold: manifold)
        body1.setVelocity(to: body1.velocity + (impulseVector / body1.mass) * manifold.normal)
        body2.setVelocity(to: body2.velocity - (impulseVector / body2.mass) * manifold.normal)
        fixOverlaps(body1: body1, body2: body2, manifold: manifold)
    }

    private static func fixOverlaps(body1: PhysicsBody, body2: PhysicsBody, manifold: CollisionManifold) {
        if body1.isMovable && body2.isMovable {
            body1.setPosition(to: body1.position + (manifold.normal * (manifold.depth / 2)))
            body2.setPosition(to: body2.position - (manifold.normal * (manifold.depth / 2)))
        } else if body1.isMovable {
            body1.setPosition(to: body1.position + (manifold.normal * manifold.depth))
        } else if body2.isMovable {
            body2.setPosition(to: body2.position - (manifold.normal * manifold.depth))
        }
    }

    private static func getImpulseVector(
        body1: PhysicsBody, body2: PhysicsBody, manifold: CollisionManifold
    ) -> Double {
        let relativeVelocity = body1.velocity - body2.velocity
        var impulse = -(1 + PhysicsConstants.coefficientOfRestitution) * relativeVelocity.dot(vector: manifold.normal)
        impulse /= (1 / body1.mass) + (1 / body2.mass)
        return impulse
    }
}
