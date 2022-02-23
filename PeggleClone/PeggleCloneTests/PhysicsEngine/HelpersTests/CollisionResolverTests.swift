//
//  CollisionResolverTests.swift
//  PeggleCloneTests
//
//  Created by Sivayogasubramanian on 12/2/22.
//

import XCTest
@testable import PeggleClone

class CollisionResolverTests: XCTestCase {
    func testResolveCollisions_forCollidingNonMovableCircleAndCircle_shouldNotResolveCollision() {
        let circle1Position = CGVector(dx: 10, dy: 10)
        let circle2Position = CGVector(dx: 10, dy: 39)
        let circle1 = CircularPhysicsBody(gameObjectType: .ball, position: circle1Position, radius: 10)
        let circle2 = CircularPhysicsBody(gameObjectType: .ball, position: circle2Position, radius: 20)

        let manifold = Intersector.detectBetween(circle1: circle1, circle2: circle2)
        CollisionResolver.resolveCollisions(body1: circle1, body2: circle2, manifold: manifold)
        XCTAssertEqual(circle1.position, circle1Position)
        XCTAssertEqual(circle2.position, circle2Position)
    }

    func testResolveCollisions_forCollidingNonMovableCircleAndMovableCircle_shouldResolveCollisionForMovableCircle() {
        let circle1Position = CGVector(dx: 10, dy: 10)
        let circle2Position = CGVector(dx: 10, dy: 39)
        let circle1 = CircularPhysicsBody(gameObjectType: .ball, position: circle1Position, radius: 10, mass: 1)
        let circle2 = CircularPhysicsBody(gameObjectType: .ball, position: circle2Position, radius: 20)

        let manifold = Intersector.detectBetween(circle1: circle1, circle2: circle2)
        CollisionResolver.resolveCollisions(body1: circle1, body2: circle2, manifold: manifold)
        XCTAssertNotEqual(circle1.position, circle1Position)
        XCTAssertEqual(circle2.position, circle2Position)
    }

    func testResolveCollisions_forCollidingCircleAndCircle_shouldResolveCollision() {
        let circle1Position = CGVector(dx: 10, dy: 10)
        let circle2Position = CGVector(dx: 10, dy: 39)
        let circle1 = CircularPhysicsBody(gameObjectType: .ball, position: circle1Position, radius: 10, mass: 1)
        let circle2 = CircularPhysicsBody(gameObjectType: .ball, position: circle2Position, radius: 20, mass: 2)

        let manifold = Intersector.detectBetween(circle1: circle1, circle2: circle2)
        CollisionResolver.resolveCollisions(body1: circle1, body2: circle2, manifold: manifold)
        XCTAssertNotEqual(circle1.position, circle1Position)
        XCTAssertNotEqual(circle2.position, circle2Position)
    }

    func testResolveCollisions_forNonCollidingCircleAndCircle_shouldNotMoveCircles() {
        let circle1Position = CGVector(dx: 10, dy: 10)
        let circle2Position = CGVector(dx: 10, dy: 41)
        let circle1 = CircularPhysicsBody(gameObjectType: .ball, position: circle1Position, radius: 10, mass: 1)
        let circle2 = CircularPhysicsBody(gameObjectType: .ball, position: circle2Position, radius: 20, mass: 2)

        let manifold = Intersector.detectBetween(circle1: circle1, circle2: circle2)
        CollisionResolver.resolveCollisions(body1: circle1, body2: circle2, manifold: manifold)
        XCTAssertEqual(circle1.position, circle1Position)
        XCTAssertEqual(circle2.position, circle2Position)
    }
}
