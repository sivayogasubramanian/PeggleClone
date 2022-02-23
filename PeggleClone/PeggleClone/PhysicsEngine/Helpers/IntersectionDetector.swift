//
//  IntersectionDetector.swift
//  PeggleClone
//
//  Created by Sivayogasubramanian on 4/2/22.
//

import Foundation

class IntersectionDetector {
    static func detectCollisions(body1: PhysicsBody, body2: PhysicsBody) -> (Bool, CollisionManifold) {
        switch (body1, body2) {
        case let (circle1, circle2) as (CircularIntersector, CircularIntersector):
            return Intersector.detectBetween(circle1: circle1, circle2: circle2)
        case let (circle, line) as (CircularIntersector, LineIntersector),
            let (line, circle) as (LineIntersector, CircularIntersector):
            return Intersector.detectBetween(circle: circle, line: line)
        case let (circle, polygon) as (CircularIntersector, PolygonIntersector),
            let (polygon, circle) as (PolygonIntersector, CircularIntersector):
            return Intersector.detectBetween(circle: circle, polygon: polygon)
        default:
            assertionFailure("Unknown physics bodies in IntersectionDetector")
            return (false, CollisionManifold(normal: .zero, depth: .zero))
        }
    }
}
