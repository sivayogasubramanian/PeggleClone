//
//  PhysicsWorld.swift
//  PeggleClone
//
//  Created by Sivayogasubramanian on 4/2/22.
//

import Foundation
import CoreGraphics
import SwiftUI

struct TwoDimensionBoundaries: Equatable {
    let xMin: Double
    let xMax: Double
    let yMin: Double
    let yMax: Double
}

enum Boundary {
    case top, right, bottom, left
}

class PhysicsWorld {
    private(set) var physicsBodies: [PhysicsBody] = []
    private(set) var worldDimension: TwoDimensionBoundaries

    init(withDimensions dimensions: TwoDimensionBoundaries) {
        worldDimension = dimensions
    }

    func addPhysicsBody(_ physicsBody: PhysicsBody) {
        physicsBodies.append(physicsBody)
    }

    func removePhysicsBody(_ physicsBody: PhysicsBody) {
        physicsBodies.removeAll(where: { $0 === physicsBody })
    }

    func updatePhysicsBodiesPositions(dt deltaTime: TimeInterval) {
        physicsBodies.forEach({ $0.updatePhysicsBody(dt: deltaTime) })
    }

    func resolveCollisions(withBoundaries: Set<Boundary>) {
        guard !physicsBodies.isEmpty else {
            return
        }

        for iIndex in 0..<physicsBodies.count - 1 {
            for jIndex in iIndex + 1..<physicsBodies.count {
                let body1 = physicsBodies[iIndex], body2 = physicsBodies[jIndex]
                resolveCollisionsOfPhysicsBodies(body1, body2)
            }
        }

        resolveCollisionsOfPhysicsBodiesBetweenBoundaries(forBoundaries: withBoundaries)
    }

    private func resolveCollisionsOfPhysicsBodiesBetweenBoundaries(forBoundaries: Set<Boundary>) {
        physicsBodies.forEach { body in
            CollisionResolver.resolveCollisions(body1: body, dimensions: worldDimension, edges: forBoundaries)
        }
    }

    private func resolveCollisionsOfPhysicsBodies(_ body1: PhysicsBody, _ body2: PhysicsBody) {
        guard GameObjects.areCollidable(body1.gameObjectType, body2.gameObjectType) else {
            return
        }
        guard IntersectionDetector.detectCollisions(body1: body1, body2: body2) else {
            return
        }

        body1.incrementHitCount()
        body2.incrementHitCount()
        CollisionResolver.resolveCollisions(body1: body1, body2: body2)
    }
}
