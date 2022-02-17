//
//  CGFloatTests.swift
//  PeggleCloneTests
//
//  Created by Sivayogasubramanian on 29/1/22.
//

import XCTest
@testable import PeggleClone

class CGFloatTests: XCTestCase {
    func testIsWithin() {
        let min = CGFloat(0), max = CGFloat(10)

        XCTAssertFalse(CGFloat(-1).isWithin(min: min, max: max))
        XCTAssertTrue(CGFloat(5).isWithin(min: min, max: max))
        XCTAssertFalse(CGFloat(11).isWithin(min: min, max: max))
    }
}
