//
//  PhysicsBodyTests.swift
//  PeggleCloneTests
//
//  Created by Sivayogasubramanian on 10/2/22.
//

import XCTest
@testable import PeggleClone

class PhysicsBodyTests: XCTestCase {
    var immovableBody: PhysicsBody!
    var movableBody: PhysicsBody!

    override func setUp() {
        super.setUp()
        immovableBody = PhysicsBody(gameObjectType: .peg, position: CGVector(dx: 1, dy: 1))
        movableBody = PhysicsBody(gameObjectType: .ball, position: CGVector(dx: 1, dy: 1), mass: 1.23)
    }

    override func tearDown() {
        immovableBody = nil
        movableBody = nil
        super.tearDown()
    }

    func testInit() {
        XCTAssertNotNil(PhysicsBody(gameObjectType: .ball, position: CGVector(dx: 1, dy: 1)))
        XCTAssertNotNil(PhysicsBody(gameObjectType: .ball, position: CGVector(dx: 1, dy: 1), mass: 1.23))
    }

    func testIncrementHitCount() {
        let oldCount = immovableBody.hitCount
        immovableBody.incrementHitCount()
        XCTAssertEqual(immovableBody.hitCount, oldCount + 1)
        immovableBody.incrementHitCount(by: 2)
        XCTAssertEqual(immovableBody.hitCount, oldCount + 3)
    }

    func testSetVelocity_whenPhysicsBodyImmovable_shouldNotSetVelocity() {
        let oldVelocity = immovableBody.velocity
        immovableBody.setVelocity(to: CGVector(dx: 100, dy: 100), isMovable: immovableBody.isMovable)
        XCTAssertEqual(immovableBody.velocity, oldVelocity)
    }

    func testSetVelocity_whenPhysicsBodyMovable_shouldSetVelocity() {
        movableBody.setVelocity(to: CGVector(dx: 100, dy: 100), isMovable: movableBody.isMovable)
        XCTAssertEqual(movableBody.velocity, CGVector(dx: 100, dy: 100))
    }

    func testSetForce_whenPhysicsBodyImmovable_shouldNotSetForce() {
        let oldForce = immovableBody.force
        immovableBody.setForce(to: CGVector(dx: 100, dy: 100), isMovable: immovableBody.isMovable)
        XCTAssertEqual(immovableBody.force, oldForce)
    }

    func testSetForce_whenPhysicsBodyMovable_shouldSetForce() {
        movableBody.setForce(to: CGVector(dx: 100, dy: 100), isMovable: movableBody.isMovable)
        XCTAssertEqual(movableBody.force, CGVector(dx: 100, dy: 100))
    }

    func testSetPosition_whenPhysicsBodyImmovable_shouldNotSetPosition() {
        let oldPosition = immovableBody.position
        immovableBody.setPosition(to: CGVector(dx: 100, dy: 100), isMovable: immovableBody.isMovable)
        XCTAssertEqual(immovableBody.position, oldPosition)
    }

    func testSetPosition_whenPhysicsBodyMovable_shouldSetForce() {
        movableBody.setPosition(to: CGVector(dx: 100, dy: 100), isMovable: movableBody.isMovable)
        XCTAssertEqual(movableBody.position, CGVector(dx: 100, dy: 100))
    }

    func testUpdatePhysicsBody_whenPhysicsBodyImmovable_shouldNotUpdate() {
        let oldVelocity = immovableBody.velocity
        let oldForce = immovableBody.force
        let oldPosition = immovableBody.position

        immovableBody.setForce(to: Constants.gravity, isMovable: immovableBody.isMovable)
        immovableBody.updatePhysicsBody(dt: 1, isMovable: immovableBody.isMovable)

        XCTAssertEqual(immovableBody.velocity, oldVelocity)
        XCTAssertEqual(immovableBody.force, oldForce)
        XCTAssertEqual(immovableBody.position, oldPosition)
    }

    func testUpdatePhysicsBody_whenPhysicsBodyMassIsZero_shouldNotUpdate() {
        let physicsBody = PhysicsBody(gameObjectType: .peg, position: CGVector(dx: 1, dy: 1), mass: 0)
        physicsBody.setForce(to: Constants.gravity, isMovable: physicsBody.isMovable)

        let oldVelocity = physicsBody.velocity
        let oldForce = physicsBody.force
        let oldPosition = physicsBody.position

        physicsBody.updatePhysicsBody(dt: 1, isMovable: physicsBody.isMovable)

        XCTAssertEqual(physicsBody.velocity, oldVelocity)
        XCTAssertEqual(physicsBody.force, oldForce)
        XCTAssertEqual(physicsBody.position, oldPosition)
    }

    func testUpdatePhysicsBody_whenPhysicsBodyMovable_shouldUpdate() {
        let oldVelocity = movableBody.velocity
        let oldForce = movableBody.force
        let oldPosition = movableBody.position

        movableBody.setForce(to: Constants.gravity, isMovable: movableBody.isMovable)
        movableBody.updatePhysicsBody(dt: 1, isMovable: movableBody.isMovable)

        XCTAssertNotEqual(movableBody.velocity, oldVelocity)
        XCTAssertNotEqual(movableBody.force, oldForce)
        XCTAssertNotEqual(movableBody.position, oldPosition)
    }

    func testResetHitCount() {
        movableBody.incrementHitCount(by: 2)
        movableBody.resetHitCount()
        XCTAssertEqual(movableBody.hitCount, 0)
    }
}
