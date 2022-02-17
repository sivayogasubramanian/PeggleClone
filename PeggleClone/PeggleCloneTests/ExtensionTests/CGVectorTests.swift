//
//  CGVectorTests.swift
//  PeggleCloneTests
//
//  Created by Sivayogasubramanian on 4/2/22.
//

import XCTest
@testable import PeggleClone

class CGVectorTests: XCTestCase {
    var left: CGVector!
    var right: CGVector!

    override func setUp() {
        super.setUp()
        left = CGVector(dx: 5, dy: 6)
        right = CGVector(dx: 2, dy: 3)
    }

    override func tearDown() {
        left = nil
        right = nil
        super.tearDown()
    }

    func testAdd() {
        XCTAssertEqual(left + right, CGVector(dx: 7, dy: 9))
    }

    func testSubtract() {
        XCTAssertEqual(left - right, CGVector(dx: 3, dy: 3))
    }

    func testNegate() {
        XCTAssertEqual(-left, CGVector(dx: -5, dy: -6))
        XCTAssertEqual(-right, CGVector(dx: -2, dy: -3))
    }

    func testMultiply() {
        XCTAssertEqual(left * 2, CGVector(dx: 10, dy: 12))
        XCTAssertEqual(3 * right, CGVector(dx: 6, dy: 9))
    }

    func testDivide() {
        XCTAssertEqual(left / 2, CGVector(dx: 2.5, dy: 3))
        XCTAssertEqual(right / 2, CGVector(dx: 1, dy: 1.5))
    }

    func testPlusAssign() {
        left += right
        XCTAssertEqual(left, CGVector(dx: 7, dy: 9))
    }

    func testMinusAssign() {
        left -= right
        XCTAssertEqual(left, CGVector(dx: 3, dy: 3))
    }

    func testEqual() {
        XCTAssertEqual(left, CGVector(dx: 5, dy: 6))
        XCTAssertEqual(right, CGVector(dx: 2, dy: 3))
    }

    func testLengthSquared() {
        XCTAssertEqual(left.lengthSquared(), 61)
    }

    func testLength() {
        XCTAssertEqual(left.length(), sqrt(61))
    }

    func testDistanceSquared() {
        XCTAssertEqual(left.distanceSquared(to: right), 18)
    }

    func testDistance() {
        XCTAssertEqual(left.distance(to: right), sqrt(18))
    }

    func testNormalize() {
        XCTAssertEqual(left.normalize(), CGVector(dx: 5 / sqrt(61), dy: 6 / sqrt(61)))
    }

    func testDot() {
        XCTAssertEqual(left.dot(vector: right), 28)
    }

    func testCross() {
        XCTAssertEqual(left.cross(vector: right), 3)
    }

    func testRotate() {
        XCTAssertEqual(left.rotate(by: 90, origin: CGVector(dx: 0, dy: 0)), CGVector(dx: -6, dy: 5))
        XCTAssertEqual(right.rotate(by: 90, origin: CGVector(dx: 0, dy: 0)), CGVector(dx: -3, dy: 2))
    }

    func testToCGPoint() {
        XCTAssertEqual(left.toCGPoint(), CGPoint(x: 5, y: 6))
        XCTAssertEqual(right.toCGPoint(), CGPoint(x: 2, y: 3))
    }
}
