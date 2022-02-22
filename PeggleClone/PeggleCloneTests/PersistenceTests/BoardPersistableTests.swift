//
//  BoardPersistableTests.swift
//  PeggleCloneTests
//
//  Created by Sivayogasubramanian on 29/1/22.
//

import CoreData
import XCTest
@testable import PeggleClone

class BoardPersistableTests: XCTestCase {
    private var viewContext: NSManagedObjectContext!

    override func setUp() {
        super.setUp()
        viewContext = TestCoreDataManager().viewContext
    }

    override func tearDown() {
        viewContext = nil
        super.tearDown()
    }

    func testFromCoreDataEntity() {
        let peg1 = Peg(color: .blue, center: .zero, radius: Constants.pegRadius, rotation: .zero)
        let peg2 = Peg(color: .orange, center: CGVector(dx: 10, dy: 10), radius: Constants.pegRadius, rotation: .zero)
        let pegEntities = [peg1, peg2].map({ $0.toCoreDataEntity(using: viewContext) })

        let block1 = TriangularBlock(color: .blue, center: .zero)
        let block2 = TriangularBlock(color: .orange, center: CGVector(dx: 10, dy: 10))
        let blockEntities = [block1, block2].map({ $0.toCoreDataEntity(using: viewContext) })

        let uuid = UUID(), name = "Test"
        let snapshot = Data(base64Encoded: "Test") ?? Data()
        let boardPegEntities = Set<PegEntity>(pegEntities)
        let boardBlockEntities = Set<TriangularBlockEntity>(blockEntities)

        let boardEntity = BoardEntity(context: viewContext)
        boardEntity.setId(to: uuid)
        boardEntity.setName(to: name)
        boardEntity.setSnapshot(to: snapshot)
        boardEntity.addToBoardPegEntities(boardPegEntities)
        boardEntity.addToBoardTriangularBlockEntities(boardBlockEntities)

        let board = Board.fromCoreDataEntity(boardEntity)
        let expectedBoard = Board(uuid: uuid, name: name, pegs: [peg1, peg2], blocks: [block1, block2])
        expectedBoard.setImage(to: snapshot)

        XCTAssertEqual(board.uuid, expectedBoard.uuid)
        XCTAssertEqual(board.name, expectedBoard.name)
        XCTAssertEqual(board.snapshot, expectedBoard.snapshot)
        XCTAssertEqual(board.pegs.count, expectedBoard.pegs.count)
        XCTAssertEqual(board.blocks.count, expectedBoard.blocks.count)
    }

    func testToCoreDataEntity() {
        let peg1 = Peg(color: .blue, center: .zero, radius: Constants.pegRadius, rotation: .zero)
        let peg2 = Peg(color: .orange, center: CGVector(dx: 10, dy: 10), radius: Constants.pegRadius, rotation: .zero)
        let block1 = TriangularBlock(color: .blue, center: .zero)
        let block2 = TriangularBlock(color: .orange, center: CGVector(dx: 10, dy: 10))

        let uuid = UUID(), name = "Test"
        let snapshot = Data(base64Encoded: "Test") ?? Data()
        let board = Board(uuid: uuid, name: name, pegs: [peg1, peg2], blocks: [block1, block2])
        board.setImage(to: snapshot)

        let boardEntity = board.toCoreDataEntity(using: viewContext)

        XCTAssertEqual(boardEntity.uuid, board.uuid)
        XCTAssertEqual(boardEntity.name, board.name)
        XCTAssertEqual(boardEntity.snapshot, board.snapshot)
        XCTAssertEqual(boardEntity.boardPegEntities.count, board.pegs.count)
        XCTAssertEqual(boardEntity.boardTriangularBlockEntities.count, board.blocks.count)
    }
}
