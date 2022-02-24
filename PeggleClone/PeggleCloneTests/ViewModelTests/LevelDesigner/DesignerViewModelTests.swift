//
//  DesignerViewModelTests.swift
//  PeggleCloneTests
//
//  Created by Sivayogasubramanian on 28/1/22.
//

import CoreData
import XCTest
@testable import PeggleClone

class DesignerViewModelTests: XCTestCase {
    private var viewModel: DesignerViewModel!
    private var viewContext: NSManagedObjectContext!

    override func setUp() {
        super.setUp()
        viewModel = DesignerViewModel()
        // assume the board size is 500x500
        viewModel.setBoardSize(to: CGSize(width: 500, height: 500))
        viewContext = TestCoreDataManager().viewContext
    }

    override func tearDown() {
        viewModel = nil
        viewContext = nil
        super.tearDown()
    }

    func testConstructor() {
        XCTAssertNotNil(viewModel.board)
        XCTAssertTrue(viewModel.isNewBoard)
        XCTAssertEqual(viewModel.boardSize, CGSize(width: 500, height: 500))
    }

    /*
     testAddPeg() and testMovePeg() do not test for validation
     (i.e. checking for peg overlaps, checking if peg is within bounds)

     These tests are done in BoardTests.swift
     */

    func testAddPeg() {
        XCTAssertEqual(viewModel.board.pegs.count, 0)
        viewModel.addPeg(at: CGPoint(x: 50, y: 50 + Constants.letterBoxYOffset),
                         color: .orange)
        XCTAssertEqual(viewModel.board.pegs.count, 1)
    }

    func testMovePeg() {
        viewModel.addPeg(at: CGPoint(x: 50, y: 50), color: .orange)
        guard let peg = viewModel.board.pegs.first else {
            return
        }

        XCTAssertEqual(peg.center.dx, 50)
        XCTAssertEqual(peg.center.dy, 50)
        viewModel.movePeg(peg: peg, to: CGPoint(x: 100, y: 100))
        XCTAssertEqual(peg.center.dx, 100)
        XCTAssertEqual(peg.center.dy, 100)
    }

    func testDeletePeg() {
        viewModel.addPeg(at: CGPoint(x: 50, y: 50), color: .orange)
        guard let peg = viewModel.board.pegs.first else {
            return
        }

        XCTAssertEqual(viewModel.board.pegs.count, 1)
        viewModel.deletePeg(peg: peg)
        XCTAssertTrue(viewModel.board.pegs.isEmpty)
    }

    func testDeletePeg_withMultiplePegs() {
        viewModel.addPeg(at: CGPoint(x: 50, y: 50), color: .orange)
        viewModel.addPeg(at: CGPoint(x: 100, y: 100), color: .blue)
        guard let peg1 = viewModel.board.pegs.first, let peg2 = viewModel.board.pegs.last else {
            return
        }

        XCTAssertEqual(viewModel.board.pegs.count, 2)
        viewModel.deletePeg(peg: peg1)
        viewModel.deletePeg(peg: peg2)
        XCTAssertTrue(viewModel.board.pegs.isEmpty)
    }

    func testSetBoard() {
        let board = Board()
        viewModel.setBoard(to: board)

        XCTAssertTrue(viewModel.board === board)
        XCTAssertFalse(viewModel.isNewBoard)
    }

    func testSetBoardName_whenNameIsValid_shouldSetBoardName() {
        XCTAssertEqual(viewModel.board.name, "")
        viewModel.setBoardName(to: "This is a test")
        XCTAssertEqual(viewModel.board.name, "This is a test")
    }

    func testSetBoardName_whenNameIsEmpty_shouldNotSetBoardName() {
        viewModel.setBoardName(to: "Initial name")
        viewModel.setBoardName(to: "")
        XCTAssertEqual(viewModel.board.name, "Initial name")
    }

    func testSetBoardSize() {
        XCTAssertEqual(viewModel.boardSize, CGSize(width: 500, height: 500))
        let newSize = CGSize(width: 100, height: 100)
        viewModel.setBoardSize(to: newSize)
        XCTAssertEqual(viewModel.boardSize, newSize)
    }

    func testResetLevelDesigner() {
        let oldBoard = viewModel.board
        viewModel.resetDesigner()
        XCTAssertFalse(viewModel.board === oldBoard)
        XCTAssertTrue(viewModel.isNewBoard)
        XCTAssertTrue(viewModel.board.boardSize != .zero)
    }

    func testLoadSavedLevels_whenThereAreNoSavedLevels_shouldReturnEmptyArray() {
        let boards = viewModel.loadSavedLevels(using: viewContext)
        XCTAssertTrue(boards.isEmpty)
    }

    func testLoadSavedLevels_whenThereIsASavedLevel_shouldReturnBoardsArray() {
        viewModel.setBoardName(to: "This is a test")
        viewModel.saveBoard(using: viewContext)

        let boards = viewModel.loadSavedLevels(using: viewContext)

        XCTAssertTrue(boards.count == 1)
    }

    func testLoadSavedLevels_whenThereAreMultipleSavedLevelsWithSameName_shouldReturnBoardsArray() {
        viewModel.setBoardName(to: "Same name")
        viewModel.saveBoard(using: viewContext)
        viewModel.setBoard(to: Board())
        viewModel.setBoardName(to: "Same name")
        viewModel.saveBoard(using: viewContext)

        let boards = viewModel.loadSavedLevels(using: viewContext)

        XCTAssertTrue(boards.count == 2)
    }

    func testLoadSavedLevels_whenThereAreMultipleSavedLevelsWithDifferentName_shouldReturnBoardsArray() {
        viewModel.setBoardName(to: "Different name")
        viewModel.saveBoard(using: viewContext)
        viewModel.setBoard(to: Board())
        viewModel.setBoardName(to: "Different name here")
        viewModel.saveBoard(using: viewContext)

        let boards = viewModel.loadSavedLevels(using: viewContext)

        XCTAssertTrue(boards.count == 2)
    }

    func testSaveBoard_whenBoardIsNewWithEmptyName_shouldNotAddNewBoard() {
        viewModel.addPeg(at: CGPoint(x: 50, y: 50), color: .orange)
        viewModel.addPeg(at: CGPoint(x: 100, y: 100), color: .blue)
        viewModel.saveBoard(using: viewContext)

        let boards = viewModel.loadSavedLevels(using: viewContext)

        XCTAssertTrue(boards.isEmpty)
    }

    func testSaveBoard_whenBoardIsNewWithValidName_shouldAddNewBoard() {
        viewModel.setBoardName(to: "This is a test")
        viewModel.addPeg(at: CGPoint(x: 50, y: 50), color: .orange)
        viewModel.addPeg(at: CGPoint(x: 100, y: 100), color: .blue)
        viewModel.saveBoard(using: viewContext)

        let boards = viewModel.loadSavedLevels(using: viewContext)

        XCTAssertTrue(boards.count == 1)
    }

    func testSaveBoard_whenBoardIsNotNew_shouldUpdateOldBoard() {
        let oldBoard = Board()
        viewModel.setBoard(to: oldBoard)
        viewModel.setBoardName(to: "test")
        viewModel.addPeg(at: CGPoint(x: 50, y: 50), color: .orange)
        viewModel.addPeg(at: CGPoint(x: 100, y: 100), color: .blue)
        viewModel.saveBoard(using: viewContext)

        var boards = viewModel.loadSavedLevels(using: viewContext)
        XCTAssertTrue(boards.count == 1)

        viewModel.addPeg(at: CGPoint(x: 150, y: 150), color: .blue)
        viewModel.setBoardName(to: "new name")
        viewModel.saveBoard(using: viewContext)

        boards = viewModel.loadSavedLevels(using: viewContext)

        XCTAssertTrue(boards.count == 1)
        XCTAssertTrue(boards.first?.name == "new name")
    }

    func testSaveBoard_whenBoardIsNotNewWithEmptyName_shouldNotUpdateOldBoardName() {
        let oldBoard = Board()
        viewModel.setBoard(to: oldBoard)
        viewModel.setBoardName(to: "test")
        viewModel.addPeg(at: CGPoint(x: 50, y: 50), color: .orange)
        viewModel.addPeg(at: CGPoint(x: 100, y: 100), color: .blue)
        viewModel.saveBoard(using: viewContext)

        var boards = viewModel.loadSavedLevels(using: viewContext)
        XCTAssertTrue(boards.count == 1)

        viewModel.addPeg(at: CGPoint(x: 150, y: 150), color: .blue)
        viewModel.setBoardName(to: "")
        viewModel.saveBoard(using: viewContext)

        boards = viewModel.loadSavedLevels(using: viewContext)

        XCTAssertTrue(boards.count == 1)
        XCTAssertTrue(boards.first?.name == "test")
    }
}
