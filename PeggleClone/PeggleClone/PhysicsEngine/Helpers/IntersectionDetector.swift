//
//  IntersectionDetector.swift
//  PeggleClone
//
//  Created by Sivayogasubramanian on 4/2/22.
//

import Foundation

class IntersectionDetector {
    static func detectCollisions(body1: PhysicsBody, body2: PhysicsBody) -> Bool {
        switch (body1, body2) {
        case let (circle1, circle2) as (CircularPhysicsBody, CircularPhysicsBody):
            return circleAndCircle(circle1: circle1, circle2: circle2)
        default:
            assertionFailure("Unknown physics bodies in IntersectionDetector")
            return false
        }
    }

    private static func circleAndCircle(circle1: CircularPhysicsBody, circle2: CircularPhysicsBody) -> Bool {
        let vectorBetweenCenters = circle1.center - circle2.center
        let radiiSum = circle1.radius + circle2.radius
        return vectorBetweenCenters.lengthSquared() < radiiSum * radiiSum
    }
}
