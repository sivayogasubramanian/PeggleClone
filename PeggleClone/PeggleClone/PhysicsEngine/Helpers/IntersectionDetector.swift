//
//  IntersectionDetector.swift
//  PeggleClone
//
//  Created by Sivayogasubramanian on 4/2/22.
//

class IntersectionDetector {
    static func detectCollisions(body1: PhysicsBody, body2: PhysicsBody) -> CollisionManifold {
        switch (body1, body2) {
        case let (circle1, circle2) as (CircularIntersector, CircularIntersector):
            return Intersector.detectBetween(circle1: circle1, circle2: circle2)
        case let (circle, line) as (CircularIntersector, LineIntersector),
            let (line, circle) as (LineIntersector, CircularIntersector):
            return Intersector.detectBetween(circle: circle, line: line)
        case let (circle, polygon) as (CircularIntersector, PolygonalIntersector),
            let (polygon, circle) as (PolygonalIntersector, CircularIntersector):
            return Intersector.detectBetween(circle: circle, polygon: polygon)
        case let (polygon1, polygon2) as (PolygonalIntersector, PolygonalIntersector):
            return Intersector.detectBetween(polygon1: polygon1, polygon2: polygon2)
        default:
            assertionFailure("Unknown physics bodies in IntersectionDetector")
            return .zero
        }
    }
}
