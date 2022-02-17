//
//  CGPointTests.swift
//  PeggleCloneTests
//
//  Created by Sivayogasubramanian on 29/1/22.
//

import XCTest
@testable import PeggleClone

class CGPointTests: XCTestCase {
    func testDistance() {
        let point1 = CGPoint(x: 0, y: 0)
        let point2 = CGPoint(x: 3, y: 4)
        XCTAssertEqual(point1.distance(toPoint: point2), CGFloat(5))
    }

    func testIsWithinBounds() {
        let minX = CGFloat(0), maxX = CGFloat(10), minY = CGFloat(0), maxY = CGFloat(10)

        let point1 = CGPoint(x: 0, y: 0)
        let point2 = CGPoint(x: 0, y: 10)
        let point3 = CGPoint(x: 10, y: 10)
        let point4 = CGPoint(x: 110, y: 10)

        XCTAssertTrue(point1.isWithinBounds(minX: minX, maxX: maxX, minY: minY, maxY: maxY))
        XCTAssertTrue(point2.isWithinBounds(minX: minX, maxX: maxX, minY: minY, maxY: maxY))
        XCTAssertTrue(point3.isWithinBounds(minX: minX, maxX: maxX, minY: minY, maxY: maxY))
        XCTAssertFalse(point4.isWithinBounds(minX: minX, maxX: maxX, minY: minY, maxY: maxY))
    }

    func testToCGVector() {
        let point1 = CGPoint(x: 101, y: 12)
        let point2 = CGPoint(x: 3, y: 4)
        XCTAssertEqual(point1.toCGVector(), CGVector(dx: 101, dy: 12))
        XCTAssertEqual(point2.toCGVector(), CGVector(dx: 3, dy: 4))
    }
}
