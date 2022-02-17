//
//  IntersectionDetectorTests.swift
//  PeggleCloneTests
//
//  Created by Sivayogasubramanian on 11/2/22.
//

import XCTest
@testable import PeggleClone

class IntersectionDetectorTests: XCTestCase {
    func testDetectCollisions_forCollidingCircleAndCircle_shouldReturnTrue() {
        let circle1 = CircularPhysicsBody(gameObjectType: .ball, position: CGVector(dx: 10, dy: 10), radius: 10)
        let circle2 = CircularPhysicsBody(gameObjectType: .ball, position: CGVector(dx: 10, dy: 39), radius: 20)
        XCTAssertTrue(IntersectionDetector.detectCollisions(body1: circle1, body2: circle2))
    }

    func testDetectCollisions_forNonCollidingCircleAndCircle_shouldReturnFalse() {
        let circle1 = CircularPhysicsBody(gameObjectType: .ball, position: CGVector(dx: 0, dy: 0), radius: 10)
        let circle2 = CircularPhysicsBody(gameObjectType: .ball, position: CGVector(dx: 0, dy: 41), radius: 20)
        XCTAssertFalse(IntersectionDetector.detectCollisions(body1: circle1, body2: circle2))
    }
}
