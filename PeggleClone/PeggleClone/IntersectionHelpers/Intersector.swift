//
//  Intersector.swift
//  PeggleClone
//
//  Created by Sivayogasubramanian on 21/2/22.
//

import Foundation
import CoreGraphics

class Intersector {
    static func detectBetween(circle1: CircularIntersector, circle2: CircularIntersector) -> (Bool, CollisionManifold) {
        let vectorBetweenCenters = circle1.center - circle2.center
        let magnitude = vectorBetweenCenters.length()
        let radiiSum = circle1.radius + circle2.radius
        let hasCollided = vectorBetweenCenters.length() < radiiSum
        let manifold = CollisionManifold(normal: vectorBetweenCenters.normalize(), depth: radiiSum - magnitude)
        return (hasCollided, manifold)
    }

    static func detectBetween(polygon1: PolygonIntersector, polygon2: PolygonIntersector) -> (Bool, CollisionManifold) {
        let axesToConsider = polygon1.edges.map({
            CGVector(dx: -$0.direction.dy, dy: $0.direction.dx).normalize()
        }) + polygon2.edges.map({
            CGVector(dx: -$0.direction.dy, dy: $0.direction.dx).normalize()
        })
        var depth = Double.infinity
        var normal = CGVector.zero

        for axis in axesToConsider {
            let (minPolygon1, maxPolygon1) = project(polygon: polygon1, onto: axis)
            let (minPolygon2, maxPolygon2) = project(polygon: polygon2, onto: axis)

            if minPolygon1 >= maxPolygon2 || minPolygon2 >= maxPolygon1 {
                return (false, .zero)
            }

            let oldDepth = depth
            depth = min(depth, abs(minPolygon1 - maxPolygon2), abs(minPolygon2 - maxPolygon1))
            if depth != oldDepth {
                normal = axis
            }
        }

        return (true, CollisionManifold(normal: normal, depth: depth))
    }

    static func detectBetween(circle: CircularIntersector, line: LineIntersector) -> (Bool, CollisionManifold) {
        let collisionNormal = (line.line.closestPointOnLine(to: circle.center) - circle.center).normalize()
        let depth = line.line.shortestDistance(from: circle.center)
        let hasCollided = depth <= circle.radius
        return (hasCollided, CollisionManifold(normal: collisionNormal, depth: circle.radius - depth))
    }

    static func detectBetween(circle: CircularIntersector, polygon: PolygonIntersector) -> (Bool, CollisionManifold) {
        let closestVector = findClosestPoint(on: polygon, to: circle)
        let centerToClosestVector = closestVector - circle.center
        let axesToConsider = [centerToClosestVector.normalize()] + polygon.edges.map({
            CGVector(dx: -$0.direction.dy, dy: $0.direction.dx).normalize()
        })
        var depth = Double.infinity
        var normal = CGVector.zero

        for axis in axesToConsider {
            let (minCircle, maxCircle) = project(circle: circle, onto: axis)
            let (minPolygon, maxPolygon) = project(polygon: polygon, onto: axis)

            if minPolygon >= maxCircle || minCircle >= maxPolygon {
                return (false, .zero)
            }

            let oldDepth = depth
            depth = min(depth, abs(minPolygon - maxCircle), abs(minCircle - maxPolygon))
            if depth != oldDepth {
                normal = axis
            }
        }

        return (true, CollisionManifold(normal: normal, depth: depth))
    }
}

// MARK: Overloaded Methods
extension Intersector {
    static func detectBetween(line: LineIntersector, circle: CircularIntersector) -> (Bool, CollisionManifold) {
        Intersector.detectBetween(circle: circle, line: line)
    }

    static func detectBetween(polygon: PolygonIntersector, circle: CircularIntersector) -> (Bool, CollisionManifold) {
        Intersector.detectBetween(circle: circle, polygon: polygon)
    }
}

// MARK: Helper Methods
extension Intersector {
    private static func project(circle: CircularIntersector, onto vector: CGVector) -> (Double, Double) {
        let direction = vector.normalize()
        let directionAndRadius = direction * circle.radius

        let point1 = circle.center + directionAndRadius, point2 = circle.center - directionAndRadius
        let dotProduct1 = point1.dot(vector: vector), dotProduct2 = point2.dot(vector: vector)

        return (min(dotProduct1, dotProduct2), max(dotProduct1, dotProduct2))
    }

    private static func project(polygon: PolygonIntersector, onto vector: CGVector) -> (Double, Double) {
        var minimum = Double.infinity
        var maximum = -Double.infinity

        for vertex in polygon.vertices {
            minimum = min(minimum, vertex.dot(vector: vector))
            maximum = max(maximum, vertex.dot(vector: vector))
        }

        return (minimum, maximum)
    }

    private static func findClosestPoint(on polygon: PolygonIntersector, to circle: CircularIntersector) -> CGVector {
        var closestPoint = CGVector.zero
        var distance = Double.infinity

        for vertex in polygon.vertices {
            let distanceToCenter = vertex.distance(to: circle.center)

            if distanceToCenter < distance {
                distance = distanceToCenter
                closestPoint = vertex
            }
        }

        return closestPoint
    }
}
