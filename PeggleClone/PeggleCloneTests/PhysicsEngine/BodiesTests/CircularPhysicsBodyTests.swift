//
//  CircularBodyTests.swift
//  PeggleCloneTests
//
//  Created by Sivayogasubramanian on 10/2/22.
//

import XCTest
import SwiftUI
@testable import PeggleClone

class CircularPhysicsBodyTests: XCTestCase {
    func testInit() {
        let position = CGVector(dx: 10, dy: 120)
        let circle = CircularPhysicsBody(gameObjectType: .ball, position: position, radius: 23, mass: 12)
        XCTAssertNotNil(circle)
    }

    func testCenter() {
        let position = CGVector(dx: 10, dy: 120)
        let circle = CircularPhysicsBody(gameObjectType: .ball, position: position, radius: 23, mass: 12)
        XCTAssertEqual(circle.center, position)
    }
}
