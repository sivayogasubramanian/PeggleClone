//
//  GameObjectsTests.swift
//  PeggleCloneTests
//
//  Created by Sivayogasubramanian on 11/2/22.
//

import XCTest
@testable import PeggleClone

class GameObjectsTests: XCTestCase {
    func testAreCollidable_forBall() {
        XCTAssertTrue(GameObjects.areCollidable(.ball, .ball))
        XCTAssertTrue(GameObjects.areCollidable(.ball, .peg))
    }

    func testAreCollidable_forPeg() {
        XCTAssertTrue(GameObjects.areCollidable(.peg, .ball))
        XCTAssertFalse(GameObjects.areCollidable(.peg, .peg))
    }
}
