//
//  PegGameObjectTests.swift
//  PeggleCloneTests
//
//  Created by Sivayogasubramanian on 10/2/22.
//

import XCTest
@testable import PeggleClone

class PegGameObjectTests: XCTestCase {
    func testInit() {
        let peg = Peg(color: .blue, center: CGVector(dx: 10, dy: 20))
        let pegGameObject = PegGameObject(fromPeg: peg)

        XCTAssertNotNil(pegGameObject)
        XCTAssertEqual(pegGameObject.position, peg.center)
        XCTAssertEqual(pegGameObject.color, peg.color)
    }

    func testEquatable() {
        let peg = Peg(color: .blue, center: CGVector(dx: 10, dy: 20))
        let pegGameObject1 = PegGameObject(fromPeg: peg)
        let pegGameObject2 = PegGameObject(fromPeg: peg)

        XCTAssertFalse(pegGameObject1 == pegGameObject2)
    }
}
