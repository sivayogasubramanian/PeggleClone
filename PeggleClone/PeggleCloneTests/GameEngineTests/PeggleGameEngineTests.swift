//
//  PeggleGameEngineTests.swift
//  PeggleCloneTests
//
//  Created by Sivayogasubramanian on 12/2/22.
//

import XCTest
@testable import PeggleClone

class PeggleGameEngineTests: XCTestCase {
    let boardSize = CGSize(width: 1_000, height: 1_000)
    var gameEngine: PeggleGameEngine!

    override func setUp() {
        super.setUp()
        let board = Board()
        board.setSize(boardSize: CGSize(width: 1_000, height: 1_000))
        gameEngine = PeggleGameEngine(board: board)
    }

    override func tearDown() {
        gameEngine = nil
        super.tearDown()
    }

    func testAddBall() {
        let point = CGPoint(x: 100, y: 100)
        gameEngine.addBall(shootingTowards: point)
        if let ball = gameEngine.ball {
            let direction = (point.toCGVector() - ball.position).normalize()
            XCTAssertEqual(ball.force, PhysicsConstants.gravity)
            XCTAssertEqual(ball.velocity, direction * PhysicsConstants.initialBallLaunchVelocityMultiplier)
        }
        XCTAssertNotNil(gameEngine.ball)
    }

    func testSimulateFor_movesBall() {
        let point = CGPoint(x: 100, y: 100)
        gameEngine.addBall(shootingTowards: point)
        let initialPosition = gameEngine.ball?.position
        gameEngine.simulateFor(dt: 2)
        XCTAssertNotEqual(gameEngine.ball?.position, initialPosition)
    }

    func testSimulateFor_doesNotMovePeg() {
        let board = Board()
        board.setSize(boardSize: boardSize)
        board.addPeg(at: CGPoint(x: 75, y: 86), color: .orange, bounds: boardSize)

        gameEngine = PeggleGameEngine(board: board)
        let initialPosition = gameEngine.pegs.first?.position
        gameEngine.simulateFor(dt: 2)

        XCTAssertEqual(gameEngine.pegs.first?.position, initialPosition)
    }

    func testSimulateFor_removesBallWhenBallExitsBounds() {
        let point = CGPoint(x: 100, y: 100)
        gameEngine.addBall(shootingTowards: point)

        // Long time to let gravity do its work
        gameEngine.simulateFor(dt: 10_000)

        XCTAssertNil(gameEngine.ball)
    }

    func testSimulateFor_removesPegsWhenBallCollidesWithPeg() {
        let board = Board()
        board.setSize(boardSize: boardSize)
        board.addPeg(at: CGPoint(x: 200, y: 200), color: .orange, bounds: boardSize)
        gameEngine = PeggleGameEngine(board: board)

        let point = CGPoint(x: 100, y: 100)
        gameEngine.addBall(shootingTowards: point)

        // Simulate collision
        var totalTime = 10.0
        while totalTime > 0 {
            gameEngine.simulateFor(dt: 0.1)
            totalTime -= 0.1
        }

        XCTAssertTrue(gameEngine.pegs.isEmpty)
    }
}
