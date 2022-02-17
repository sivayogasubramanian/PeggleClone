//
//  GameViewModelTests.swift
//  PeggleCloneTests
//
//  Created by Sivayogasubramanian on 10/2/22.
//

import XCTest
import SwiftUI
@testable import PeggleClone

class GameViewModelTests: XCTestCase {
    var viewModel: GameViewModel!

    override func setUp() {
        super.setUp()
        let board = Board()
        board.setSize(boardSize: CGSize(width: 100, height: 100))
        viewModel = GameViewModel(board: board)
    }

    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }

    func testInit() {
        let board = Board()
        XCTAssertNotNil(GameViewModel(board: board))
    }

    func testShootBallTowards() {
        viewModel.shootBallTowards(point: CGPoint(x: 50, y: 50))
        // Shooting a ball will create a physics object
        XCTAssertNotNil(viewModel.ball)
    }

    func testGetAngleForCannon() {
        let angle1 = viewModel.getAngleForCanon(using: CGPoint(x: 50, y: 50))
        XCTAssertEqual(angle1, Angle(radians: .zero))

        let angle2 = viewModel.getAngleForCanon(using: CGPoint(x: 25, y: 25))
        XCTAssertEqual(angle2.degrees.rounded(), 45)

        let angle3 = viewModel.getAngleForCanon(using: CGPoint(x: 75, y: 25))
        XCTAssertEqual(angle3.degrees.rounded(), -45)
    }

    func testStart() {
        viewModel.startSimulation()
        XCTAssertNotNil(viewModel.displaylink)
    }
}
