//
//  Intersector.swift
//  PeggleClone
//
//  Created by Sivayogasubramanian on 21/2/22.
//

import Foundation
import CoreGraphics

class Intersector {
    static func detectBetween(circle1: CircularIntersector, circle2: CircularIntersector) -> Bool {
        let vectorBetweenCenters = circle1.center - circle2.center
        let radiiSum = circle1.radius + circle2.radius
        return vectorBetweenCenters.lengthSquared() < radiiSum * radiiSum
    }

    static func detectBetween(polygon1: PolygonIntersector, polygon2: PolygonIntersector) -> Bool {
        let axesToConsider = polygon1.edges.map({
            CGVector(dx: -$0.direction.dy, dy: $0.direction.dx)
        }) + polygon2.edges.map({
            CGVector(dx: -$0.direction.dy, dy: $0.direction.dx)
        })

        for axis in axesToConsider {
            let (minPolygon1, maxPolygon1) = project(polygon: polygon1, onto: axis)
            let (minPolygon2, maxPolygon2) = project(polygon: polygon2, onto: axis)

            if minPolygon1 >= maxPolygon2 || minPolygon2 >= maxPolygon1 {
                return false
            }
        }

        return true
    }

    static func detectBetween(circle: CircularIntersector, line: LineIntersector) -> Bool {
        let distanceFromCenterToLine = line.line.shortestDistance(from: circle.center)
        return distanceFromCenterToLine < circle.radius
    }

    static func detectBetween(circle: CircularIntersector, polygon: PolygonIntersector) -> Bool {
        let closestVector = findClosestPoint(on: polygon, to: circle)
        let centerToClosestVector = closestVector - circle.center

        let axesToConsider = [centerToClosestVector] + polygon.edges.map({
            CGVector(dx: -$0.direction.dy, dy: $0.direction.dx)
        })

        for axis in axesToConsider {
            let (minCircle, maxCircle) = project(circle: circle, onto: axis)
            let (minPolygon, maxPolygon) = project(polygon: polygon, onto: axis)

            if minPolygon >= maxCircle || minCircle >= maxPolygon {
                return false
            }
        }

        return true
    }
}

// MARK: Overloaded Methods
extension Intersector {
    static func detectBetween(line: LineIntersector, circle: CircularIntersector) -> Bool {
        Intersector.detectBetween(circle: circle, line: line)
    }

    static func detectBetween(polygon: PolygonIntersector, circle: CircularIntersector) -> Bool {
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
