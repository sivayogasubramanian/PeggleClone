//
//  LineTests.swift
//  PeggleCloneTests
//
//  Created by Sivayogasubramanian on 20/2/22.
//

import XCTest
@testable import PeggleClone

class LineTests: XCTestCase {
    func testConstructor() {
        let line = Line(start: CGVector(dx: 1, dy: 2), end: CGVector(dx: 3, dy: 4))
        XCTAssertNotNil(line)
    }

    func testDistanceToLine_whenLineVertical() {
        let verticalLine = Line(start: CGVector(dx: 3, dy: 2), end: CGVector(dx: 3, dy: 4))
        let point = CGVector(dx: 5, dy: 4)

        XCTAssertEqual(verticalLine.distanceToLine(from: point), 2)
    }

    func testDistanceToLine_whenLineHorizontal() {
        let horizontalLine = Line(start: CGVector(dx: 1, dy: 2), end: CGVector(dx: 3, dy: 2))
        let point = CGVector(dx: 5, dy: 4)

        XCTAssertEqual(horizontalLine.distanceToLine(from: point), 2)
    }

    func testDistanceToLine_withPositivePoints() {
        let line = Line(start: CGVector(dx: 1, dy: 2), end: CGVector(dx: 3, dy: 7))
        let point = CGVector(dx: 5, dy: 4)

        XCTAssertEqual(line.distanceToLine(from: point), 16 / 29 * sqrt(29))
    }

    func testDistanceToLine_withNegativePoints_forLine() {
        let line = Line(start: CGVector(dx: -2, dy: -2), end: CGVector(dx: 3, dy: 3))
        let point = CGVector(dx: 0, dy: 6 * sqrt(2))

        XCTAssertEqual(line.distanceToLine(from: point), 6)
    }

    func testDistanceToLine_withNegativePoints_forPoint() {
        let line = Line(start: CGVector(dx: -2, dy: -2), end: CGVector(dx: 3, dy: 3))
        let point = CGVector(dx: 0, dy: -6 * sqrt(2))

        XCTAssertEqual(line.distanceToLine(from: point), 6)
    }
}
