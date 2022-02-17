//
//  CGVector.swift
//  PeggleClone
//
//  Created by Sivayogasubramanian on 4/2/22.
//

import Foundation
import CoreGraphics

// MARK: Operators
extension CGVector {
    static func + (left: CGVector, right: CGVector) -> CGVector {
        CGVector(dx: left.dx + right.dx, dy: left.dy + right.dy)
    }

    static func - (left: CGVector, right: CGVector) -> CGVector {
        CGVector(dx: left.dx - right.dx, dy: left.dy - right.dy)
    }

    static prefix func - (vector: CGVector) -> CGVector {
        CGVector(dx: -vector.dx, dy: -vector.dy)
    }

    static func * (left: CGVector, scalar: Double) -> CGVector {
        CGVector(dx: left.dx * scalar, dy: left.dy * scalar)
    }

    static func / (left: CGVector, scalar: Double) -> CGVector {
        CGVector(dx: left.dx / scalar, dy: left.dy / scalar)
    }

    static func * (scalar: Double, right: CGVector) -> CGVector {
        right * scalar
    }

    static func += (left: inout CGVector, right: CGVector) {
        left = CGVector(dx: left.dx + right.dx, dy: left.dy + right.dy)
    }

    static func -= (left: inout CGVector, right: CGVector) {
        left = CGVector(dx: left.dx - right.dx, dy: left.dy - right.dy)
    }
}

// MARK: Vector Math
extension CGVector {
    func lengthSquared() -> Double {
        dx * dx + dy * dy
    }

    func length() -> Double {
        sqrt(lengthSquared())
    }

    func distanceSquared(to anotherVector: CGVector) -> Double {
        let deltaX = dx - anotherVector.dx
        let deltaY = dy - anotherVector.dy
        return deltaX * deltaX + deltaY * deltaY
    }

    func distance(to anotherVector: CGVector) -> Double {
        sqrt(distanceSquared(to: anotherVector))
    }

    func normalize() -> CGVector {
        self / length()
    }

    func dot(vector anotherVector: CGVector) -> Double {
        dx * anotherVector.dx + dy * anotherVector.dy
    }

    func cross(vector anotherVector: CGVector) -> Double {
        dx * anotherVector.dy - dy * anotherVector.dx
    }

    func rotate(by angleInDegrees: Double, origin: CGVector) -> CGVector {
        let xOne = dx - origin.dx
        let yOne = dy - origin.dy

        let angleInRadians = Utils.deg2rad(angleInDegrees)
        let cosine = cos(angleInRadians), sine = sin(angleInRadians)

        let xPrime = xOne * cosine - yOne * sine
        let yPrime = xOne * sine + yOne * cosine

        return CGVector(dx: xPrime + origin.dx, dy: yPrime + origin.dy)
    }
}

// MARK: Converters
extension CGVector {
    func toCGPoint() -> CGPoint {
        CGPoint(x: dx, y: dy)
    }
}
