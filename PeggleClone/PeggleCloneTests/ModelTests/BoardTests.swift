//
//  BoardTests.swift
//  PeggleCloneTests
//
//  Created by Sivayogasubramanian on 28/1/22.
//

import XCTest
@testable import PeggleClone

class BoardTests: XCTestCase {
    func testConstructor_withoutId() {
        let board = Board()

        XCTAssertNotNil(board.uuid)
        XCTAssertEqual(board.name, "")
        XCTAssertTrue(board.pegs.isEmpty)
        XCTAssertEqual(board.snapshot, .init())
    }

    func testConstructor_withId() {
        let uuid = UUID()
        let board = Board(uuid: uuid, name: "example", pegs: [Peg(color: .blue, center: .zero)], blocks: [])

        XCTAssertEqual(board.uuid, uuid)
        XCTAssertEqual(board.name, "example")
        XCTAssertTrue(board.pegs.count == 1)
        XCTAssertTrue(board.blocks.isEmpty)
        XCTAssertEqual(board.snapshot, .init())
    }

    func testSetName_withEmptyString_shouldNotChangeName() {
        let board = Board()
        board.setName(to: "Testing")

        XCTAssertEqual(board.name, "Testing")
        board.setName(to: "")
        XCTAssertEqual(board.name, "Testing")
    }

    func testSetName_withValidName_shouldChangeName() {
        let board = Board()

        XCTAssertEqual(board.name, "")
        board.setName(to: "Level 1")
        XCTAssertEqual(board.name, "Level 1")
    }

    func testSetImage_withNil_shouldNotChangeImageData() {
        let board = Board()

        XCTAssertEqual(board.snapshot, .init())
        board.setImage(to: nil)
        XCTAssertEqual(board.snapshot, .init())
    }

    func testSetImage_withValidData_shouldChangeImageData() {
        let board = Board()

        XCTAssertEqual(board.snapshot, .init())
        // Using a string to replicate a image in binary data format
        board.setImage(to: Data(base64Encoded: "This is a mock image"))
        XCTAssertEqual(board.snapshot, .init())
    }

    func testAddPeg_withNilColor_shouldNotAddPeg() {
        let board = Board()
        let point = CGPoint(x: 50, y: 50)
        let bounds = CGSize(width: 100, height: 100)

        XCTAssertTrue(board.pegs.isEmpty)
        _ = board.addPeg(at: point, color: nil, bounds: bounds)
        XCTAssertTrue(board.pegs.isEmpty)
    }

    func testAddPeg_withValidPoint_shouldAddPeg() {
        let board = Board()
        let point = CGPoint(x: 50, y: 50)
        let bounds = CGSize(width: 100, height: 100)

        XCTAssertTrue(board.pegs.isEmpty)
        _ = board.addPeg(at: point, color: .blue, bounds: bounds)
        XCTAssertTrue(board.pegs.count == 1)
    }

    func testAddPeg_withInvalidPoint_shouldNotAddPeg() {
        let board = Board()
        let point = CGPoint.zero
        let bounds = CGSize(width: 100, height: 100)

        XCTAssertTrue(board.pegs.isEmpty)
        _ = board.addPeg(at: point, color: .blue, bounds: bounds)
        XCTAssertTrue(board.pegs.isEmpty)
    }

    func testAddPeg_withPointJustOutOfBounds_shouldNotAddPeg() {
        let board = Board()
        let point = CGPoint(x: 100 - Constants.pegRadius + 1, y: 100 - Constants.pegRadius)
        let bounds = CGSize(width: 100, height: 100)

        XCTAssertTrue(board.pegs.isEmpty)
        _ = board.addPeg(at: point, color: .blue, bounds: bounds)
        XCTAssertTrue(board.pegs.isEmpty)
    }

    func testAddPeg_withNoOverlappingPegs_shouldAddPeg() {
        let board = Board()
        let point1 = CGPoint(x: 40, y: 40)
        let point2 = CGPoint(x: 100, y: 100)
        let bounds = CGSize(width: 200, height: 200)

        _ = board.addPeg(at: point1, color: .blue, bounds: bounds)
        _ = board.addPeg(at: point2, color: .orange, bounds: bounds)

        XCTAssertTrue(board.pegs.count == 2)
    }

    func testAddPeg_withOverlappingPegs_shouldNotAddPeg() {
        let board = Board()
        let point1 = CGPoint(x: 40, y: 40)
        let point2 = CGPoint(x: 50, y: 50)
        let bounds = CGSize(width: 100, height: 100)

        _ = board.addPeg(at: point1, color: .blue, bounds: bounds)
        _ = board.addPeg(at: point2, color: .orange, bounds: bounds)

        XCTAssertTrue(board.pegs.count == 1)
    }

    func testDeletePeg() {
        let board = Board()
        let point1 = CGPoint(x: 40, y: 40)
        let point2 = CGPoint(x: 100, y: 100)
        let bounds = CGSize(width: 200, height: 200)

        _ = board.addPeg(at: point1, color: .blue, bounds: bounds)
        _ = board.addPeg(at: point2, color: .orange, bounds: bounds)

        XCTAssertTrue(board.pegs.count == 2)
        if let peg = board.pegs.first {
            board.deletePeg(peg: peg)
        }
        XCTAssertTrue(board.pegs.count == 1)
    }

    func testRemoveAllPegs() {
        let board = Board()
        let point1 = CGPoint(x: 40, y: 40)
        let point2 = CGPoint(x: 100, y: 100)
        let bounds = CGSize(width: 200, height: 200)

        _ = board.addPeg(at: point1, color: .blue, bounds: bounds)
        _ = board.addPeg(at: point2, color: .orange, bounds: bounds)

        XCTAssertTrue(board.pegs.count == 2)
        board.removeAllPegs()
        XCTAssertTrue(board.pegs.isEmpty)
    }

    func testMovePeg_withValidNewCenter_shouldMovePeg() {
        let peg = Peg(color: .blue, center: CGVector(dx: 40, dy: 40))
        let board = Board(uuid: UUID(), name: "board", pegs: [peg], blocks: [])

        board.movePeg(peg: peg, to: CGPoint(x: 50, y: 50), bounds: CGSize(width: 100, height: 100))

        XCTAssertTrue(peg.center.dx == 50)
        XCTAssertTrue(peg.center.dy == 50)
    }

    func testMovePeg_withNewCenterOutOfBounds_shouldNotMovePeg() {
        let peg = Peg(color: .blue, center: CGVector(dx: 40, dy: 40))
        let board = Board(uuid: UUID(), name: "board", pegs: [peg], blocks: [])

        board.movePeg(peg: peg, to: CGPoint(x: 100, y: 100), bounds: CGSize(width: 100, height: 100))

        XCTAssertTrue(peg.center.dx == 40)
        XCTAssertTrue(peg.center.dy == 40)
    }

    func testMovePeg_withNewCenterOverlappingAnotherPeg_shouldNotMovePeg() {
        let peg1 = Peg(color: .blue, center: CGVector(dx: 40, dy: 40))
        let peg2 = Peg(color: .blue, center: CGVector(dx: 100, dy: 100))
        let board = Board(uuid: UUID(), name: "board", pegs: [peg1, peg2], blocks: [])

        board.movePeg(peg: peg1, to: CGPoint(x: 200, y: 200), bounds: CGSize(width: 100, height: 100))

        XCTAssertTrue(peg1.center.dx == 40)
        XCTAssertTrue(peg1.center.dy == 40)
    }
}
