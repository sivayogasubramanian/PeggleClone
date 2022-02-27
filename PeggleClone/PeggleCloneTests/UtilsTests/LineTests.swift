//
//  LineTests.swift
//  PeggleCloneTests
//
//  Created by Sivayogasubramanian on 27/2/22.
//

import XCTest
@testable import PeggleClone

class LineTests: XCTestCase {
    func testConstructor() {
        let line = Line(start: CGVector(dx: 1, dy: 2), end: CGVector(dx: 3, dy: 4))
        XCTAssertNotNil(line)
    }

    func testClosestPointOnLine_whenLineVertical() {
        let verticalLine = Line(start: CGVector(dx: 3, dy: 2), end: CGVector(dx: 3, dy: 4))
        let point = CGVector(dx: 5, dy: 4)
        let closestPoint = verticalLine.closestPointOnLine(to: point)

        XCTAssertEqual(closestPoint, CGVector(dx: 3, dy: 4))
    }

    func testClosestPointOnLine_whenLineHorizontal() {
        let horizontalLine = Line(start: CGVector(dx: 1, dy: 2), end: CGVector(dx: 3, dy: 2))
        let point = CGVector(dx: 5, dy: 4)
        let closestPoint = horizontalLine.closestPointOnLine(to: point)

        XCTAssertEqual(closestPoint, CGVector(dx: 5, dy: 2))
    }

    func testClosestPointOnLine_withPositivePoints() {
        let line = Line(start: CGVector(dx: 1, dy: 2), end: CGVector(dx: 3, dy: 7))
        let point = CGVector(dx: 5, dy: 4)
        let closestPoint = line.closestPointOnLine(to: point)

        XCTAssertEqual(point.distance(to: closestPoint).rounded(), line.shortestDistance(from: point).rounded())
    }

    func testClosestPointOnLine_withNegativePoints_forLine() {
        let line = Line(start: CGVector(dx: -2, dy: -2), end: CGVector(dx: 3, dy: 3))
        let point = CGVector(dx: 0, dy: 6 * sqrt(2))
        let closestPoint = line.closestPointOnLine(to: point)

        XCTAssertEqual(point.distance(to: closestPoint).rounded(), line.shortestDistance(from: point).rounded())
    }

    func testClosestPointOnLine_withNegativePoints_forPoint() {
        let line = Line(start: CGVector(dx: -2, dy: -2), end: CGVector(dx: 3, dy: 3))
        let point = CGVector(dx: 0, dy: -6 * sqrt(2))
        let closestPoint = line.closestPointOnLine(to: point)

        XCTAssertEqual(point.distance(to: closestPoint).rounded(), line.shortestDistance(from: point).rounded())
    }

    func testDistanceToLine_whenLineVertical() {
        let verticalLine = Line(start: CGVector(dx: 3, dy: 2), end: CGVector(dx: 3, dy: 4))
        let point = CGVector(dx: 5, dy: 4)

        XCTAssertEqual(verticalLine.shortestDistance(from: point), 2)
    }

    func testDistanceToLine_whenLineHorizontal() {
        let horizontalLine = Line(start: CGVector(dx: 1, dy: 2), end: CGVector(dx: 3, dy: 2))
        let point = CGVector(dx: 5, dy: 4)

        XCTAssertEqual(horizontalLine.shortestDistance(from: point), 2)
    }

    func testDistanceToLine_withPositivePoints() {
        let line = Line(start: CGVector(dx: 1, dy: 2), end: CGVector(dx: 3, dy: 7))
        let point = CGVector(dx: 5, dy: 4)

        XCTAssertEqual(line.shortestDistance(from: point), 16 / 29 * sqrt(29))
    }

    func testDistanceToLine_withNegativePoints_forLine() {
        let line = Line(start: CGVector(dx: -2, dy: -2), end: CGVector(dx: 3, dy: 3))
        let point = CGVector(dx: 0, dy: 6 * sqrt(2))

        XCTAssertEqual(line.shortestDistance(from: point), 6)
    }

    func testDistanceToLine_withNegativePoints_forPoint() {
        let line = Line(start: CGVector(dx: -2, dy: -2), end: CGVector(dx: 3, dy: 3))
        let point = CGVector(dx: 0, dy: -6 * sqrt(2))

        XCTAssertEqual(line.shortestDistance(from: point), 6)
    }
}
