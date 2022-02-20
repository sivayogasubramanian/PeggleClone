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
        case let (circle, line) as (CircularPhysicsBody, LinePhysicsBody),
            let (line, circle) as (LinePhysicsBody, CircularPhysicsBody):
            circleAndLine(circle: circle, line: line)
        default:
            assertionFailure("Unknown physics bodies in CollisionResolver")
        }
    }

    private static func circleAndLine(circle: CircularPhysicsBody, line: LinePhysicsBody) {
        let collisionNormal = (circle.center - line.closestPointOnLine(to: circle.center)).normalize()
        let impulseVector = getImpulseVector(collisionNormal: collisionNormal, body1: circle, body2: line, cof: 1)
        circle.setVelocity(to: circle.velocity + impulseVector)
        line.setVelocity(to: line.velocity - impulseVector)
        fixOverlapForCircleAndLineCollisions(circle, line, collisionNormal)
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
        body2: PhysicsBody,
        cof: Double = PhysicsConstants.coefficientOfRestitution
    ) -> CGVector {
        let relativeVelocity = body1.velocity - body2.velocity
        let velocityAlongNormal = relativeVelocity.dot(vector: collisionNormal)
        var impulse = -cof * velocityAlongNormal
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

    private static func fixOverlapForCircleAndLineCollisions(
        _ circle: CircularPhysicsBody,
        _ line: LinePhysicsBody,
        _ collisionNormal: CGVector
    ) {
        let distance = line.shortestDistance(from: circle.center)
        let depth = circle.radius - distance

        if distance < circle.radius {
            circle.setPosition(to: circle.center + (depth * collisionNormal))
        }
    }
}
