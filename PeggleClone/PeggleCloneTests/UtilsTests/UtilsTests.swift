//
//  UtilsTests.swift
//  PeggleCloneTests
//
//  Created by Sivayogasubramanian on 10/2/22.
//

import XCTest
@testable import PeggleClone

class UtilsTests: XCTestCase {
    func testDeg2Rad() {
        XCTAssertEqual(Utils.deg2rad(180), .pi)
        XCTAssertEqual(Utils.deg2rad(90), .pi / 2)
        XCTAssertEqual(Utils.deg2rad(45), .pi / 4)
    }

    func testPegColorToImageFileName() {
        XCTAssertEqual(Utils.pegColorToImagePegFileName(color: .orange), "peg-orange")
        XCTAssertEqual(Utils.pegColorToImagePegFileName(color: .blue), "peg-blue")
        XCTAssertEqual(Utils.pegColorToImagePegFileName(color: .orange, isHit: true), "peg-orange-glow")
        XCTAssertEqual(Utils.pegColorToImagePegFileName(color: .blue, isHit: true), "peg-blue-glow")
    }

    func testCannonImageFileName() {
        XCTAssertEqual(Utils.cannonImageFileName(isCannonLoaded: true), "cannon-loaded")
        XCTAssertEqual(Utils.cannonImageFileName(isCannonLoaded: false), "cannon-unloaded")
    }
}
