//
//  BallGameObjectTests.swift
//  PeggleCloneTests
//
//  Created by Sivayogasubramanian on 10/2/22.
//

import XCTest
@testable import PeggleClone

class BallGameObjectTests: XCTestCase {
    func testInit() {
        let ball = BallGameObject(position: CGVector(dx: 10, dy: 20))
        XCTAssertNotNil(ball)
    }
}
