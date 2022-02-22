//
//  PegTests.swift
//  PeggleCloneTests
//
//  Created by Sivayogasubramanian on 28/1/22.
//

import XCTest
@testable import PeggleClone

class PegTests: XCTestCase {
    func testConstructor_withoutId() {
        let peg = Peg(color: .blue, center: .zero, radius: Constants.pegRadius, rotation: .zero)

        XCTAssertNotNil(peg.uuid)
        XCTAssertEqual(peg.color, .blue)
        XCTAssertEqual(peg.center, .zero)
    }

    func testConstructor_withId() {
        let uuid = UUID()
        let peg = Peg(uuid: uuid, color: .orange, center: .zero, radius: Constants.pegRadius, rotation: .zero)

        XCTAssertEqual(peg.uuid, uuid)
        XCTAssertEqual(peg.color, .orange)
        XCTAssertEqual(peg.center, .zero)
    }

    func testChangeCenter() {
        let newCenter = CGVector(dx: 10, dy: 10)
        let peg = Peg(color: .blue, center: .zero, radius: Constants.pegRadius, rotation: .zero)

        XCTAssertEqual(peg.center, .zero)
        peg.setCenter(to: newCenter)
        XCTAssertEqual(peg.center, newCenter)
    }
}
