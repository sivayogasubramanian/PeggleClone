//
//  CollisionResolver.swift
//  PeggleClone
//
//  Created by Sivayogasubramanian on 5/2/22.
//

import Foundation
import CoreGraphics

class CollisionResolver {
    static func resolveCollisions(body1: PhysicsBody, body2: PhysicsBody) {
        switch (body1, body2) {
        case let (circle1, circle2) as (CircularPhysicsBody, CircularPhysicsBody):
            circleAndCircle(circle1: circle1, circle2: circle2)
        default:
            assertionFailure("Unknown physics bodies in CollisionResolver")
        }
    }

    static func resolveCollisions(body1: PhysicsBody, dimensions: TwoDimensionBoundaries, edges: Set<Boundary>) {
        switch body1 {
        case let circle1 as CircularPhysicsBody:
            circleAndBoundary(circle: circle1, dimensions: dimensions, edges: edges)
        default:
            assertionFailure("Unknown physics body in CollisionResolver")
        }
    }

    private static func circleAndBoundary(
        circle: CircularPhysicsBody,
        dimensions: TwoDimensionBoundaries,
        edges: Set<Boundary>
    ) {
        let currentVelocity = circle.velocity
        let leftMostPoint = circle.center.dx - circle.radius
        let rightMostPoint = circle.center.dx + circle.radius
        let bottomMostPoint = circle.center.dy + circle.radius
        let topMostPoint = circle.center.dy - circle.radius

        if leftMostPoint < dimensions.xMin && edges.contains(.left) {
            let difference = abs(leftMostPoint - dimensions.xMin)
            circle.setVelocity(to: CGVector(dx: -currentVelocity.dx, dy: currentVelocity.dy))
            circle.setPosition(to: CGVector(dx: circle.position.dx + difference, dy: circle.position.dy))
        }

        if rightMostPoint > dimensions.xMax && edges.contains(.right) {
            let difference = abs(rightMostPoint - dimensions.xMax)
            circle.setVelocity(to: CGVector(dx: -currentVelocity.dx, dy: currentVelocity.dy))
            circle.setPosition(to: CGVector(dx: circle.position.dx - difference, dy: circle.position.dy))
        }

        if topMostPoint < dimensions.yMin && edges.contains(.top) {
            let difference = abs(topMostPoint - dimensions.yMin)
            circle.setVelocity(to: CGVector(dx: currentVelocity.dx, dy: -currentVelocity.dy))
            circle.setPosition(to: CGVector(dx: circle.position.dx, dy: circle.position.dy + difference))
        }

        if bottomMostPoint > dimensions.yMax && edges.contains(.bottom) {
            let difference = abs(bottomMostPoint - dimensions.yMax)
            circle.setVelocity(to: CGVector(dx: currentVelocity.dx, dy: -currentVelocity.dy))
            circle.setPosition(to: CGVector(dx: circle.position.dx, dy: circle.position.dy - difference))
        }
    }

    private static func circleAndCircle(circle1: CircularPhysicsBody, circle2: CircularPhysicsBody) {
        let collisionNormal = (circle1.position - circle2.position).normalize()
        let impulseVector = getImpulseVector(collisionNormal: collisionNormal, body1: circle1, body2: circle2)
        circle1.setVelocity(to: circle1.velocity + impulseVector)
        circle2.setVelocity(to: circle2.velocity - impulseVector)
        fixOverlapForCircleAndCircleCollisions(circle1, circle2, collisionNormal)
    }

    private static func getImpulseVector(
        collisionNormal: CGVector,
        body1: PhysicsBody,
        body2: PhysicsBody
    ) -> CGVector {
        let relativeVelocity = body1.velocity - body2.velocity
        let velocityAlongNormal = relativeVelocity.dot(vector: collisionNormal)
        var impulse = -PhysicsConstants.coefficientOfRestitution * velocityAlongNormal
        impulse /= (1 / body1.mass) + (1 / body2.mass)
        return collisionNormal * impulse
    }

    private static func fixOverlapForCircleAndCircleCollisions(
        _ circle1: CircularPhysicsBody,
        _ circle2: CircularPhysicsBody,
        _ collisionNormal: CGVector
    ) {
        let centerToCenterVector = circle1.position - circle2.position
        let radiiSum = circle1.radius + circle2.radius

        if centerToCenterVector.lengthSquared() < radiiSum * radiiSum {
            let depth = radiiSum - centerToCenterVector.length()

            if circle1.isMovable && circle2.isMovable {
                circle1.setPosition(to: circle1.position + collisionNormal * depth / 2)
                circle2.setPosition(to: circle2.position - collisionNormal * depth / 2)
            } else if circle1.isMovable {
                circle1.setPosition(to: (circle1.position + collisionNormal * depth))
            } else if circle2.isMovable {
                circle2.setPosition(to: (circle2.position - collisionNormal * depth))
            }
        }
    }
}
