//
//  PhysicsWorldTests.swift
//  PeggleCloneTests
//
//  Created by Sivayogasubramanian on 12/2/22.
//

import XCTest
@testable import PeggleClone

class PhysicsWorldTests: XCTestCase {
    var world: PhysicsWorld!

    override func setUp() {
        super.setUp()
        world = PhysicsWorld()
    }

    override func tearDown() {
        world = nil
        super.tearDown()
    }

    func testAddPhysicsBody() {
        XCTAssertTrue(world.physicsBodies.isEmpty)
        world.addPhysicsBody(PhysicsBody(gameObjectType: .ball, position: .zero))
        XCTAssertEqual(world.physicsBodies.count, 1)
    }

    func testRemovePhysicsBody() {
        XCTAssertTrue(world.physicsBodies.isEmpty)
        let body = PhysicsBody(gameObjectType: .ball, position: .zero)
        world.addPhysicsBody(body)
        world.removePhysicsBody(body)
        XCTAssertTrue(world.physicsBodies.isEmpty)
    }

    func testUpdatePhysicsBodiesPositions() {
        let body = PhysicsBody(gameObjectType: .ball, position: .zero, mass: 1)
        body.setForce(to: PhysicsConstants.gravity, isMovable: body.isMovable)
        world.addPhysicsBody(body)
        world.updatePhysicsBodiesPositions(dt: 1)
        XCTAssertNotEqual(body.position, .zero)
    }

    func testResolveCollisions_forCollisionBetweenPhysicsBodies() {
        let circle1Position = CGVector(dx: 10, dy: 10)
        let circle2Position = CGVector(dx: 10, dy: 39)
        let circle1 = CircularPhysicsBody(gameObjectType: .ball, position: circle1Position, radius: 10, mass: 1)
        let circle2 = CircularPhysicsBody(gameObjectType: .ball, position: circle2Position, radius: 20, mass: 2)
        world.addPhysicsBody(circle1)
        world.addPhysicsBody(circle2)
        world.resolveCollisions()
        XCTAssertNotEqual(circle1.position, circle1Position)
        XCTAssertNotEqual(circle2.position, circle2Position)
    }

    func testResolveCollisions_forCollisionBetweenBoundaries() {
        world = PhysicsWorld()
        world.addPhysicsBody(LinePhysicsBody(start: CGVector(dx: 10, dy: 0), end: CGVector(dx: 10, dy: 40)))
        let circle1Position = CGVector(dx: 11, dy: 40)
        let circle1 = CircularPhysicsBody(gameObjectType: .ball, position: circle1Position, radius: 10, mass: 1)
        world.addPhysicsBody(circle1)
        world.resolveCollisions()
        XCTAssertNotEqual(circle1.position, circle1Position)
    }
}
