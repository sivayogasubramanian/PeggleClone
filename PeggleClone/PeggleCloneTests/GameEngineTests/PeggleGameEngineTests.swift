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
        _ = board.addPeg(at: CGPoint(x: 500, y: 500), color: .orange)
        gameEngine = PeggleGameEngine(board: board)
    }

    override func tearDown() {
        gameEngine = nil
        super.tearDown()
    }

    func testAddBall() {
        let point = CGPoint(x: 100, y: 100)
        gameEngine.addBall(shootingTowards: point)
        if let ball = gameEngine.mainBall {
            let direction = (point.toCGVector() - ball.physicsBody.position).normalize()
            XCTAssertEqual(ball.physicsBody.force, Constants.gravity)
            XCTAssertEqual(ball.physicsBody.velocity, direction * Constants.initialBallLaunchVelocity)
        }
        XCTAssertNotNil(gameEngine.mainBall)
    }

    func testSimulateFor_movesBall() {
        let point = CGPoint(x: 100, y: 100)
        gameEngine.addBall(shootingTowards: point)
        let initialPosition = gameEngine.mainBall?.physicsBody.position
        gameEngine.simulateFor(dt: 2)
        XCTAssertNotEqual(gameEngine.mainBall?.physicsBody.position, initialPosition)
    }

    func testSimulateFor_doesNotMovePeg() {
        let board = Board()
        board.setSize(boardSize: boardSize)
        _ = board.addPeg(at: CGPoint(x: 75, y: 86), color: .orange)

        gameEngine = PeggleGameEngine(board: board)
        let initialPosition = gameEngine.pegs.first?.physicsBody.position
        gameEngine.simulateFor(dt: 2)

        XCTAssertEqual(gameEngine.pegs.first?.physicsBody.position, initialPosition)
    }

    func testSimulateFor_removesBallWhenBallExitsBounds() {
        let point = CGPoint(x: 100, y: 100)
        gameEngine.addBall(shootingTowards: point)

        // Long time to let gravity do its work
        gameEngine.simulateFor(dt: 10_000)

        XCTAssertNil(gameEngine.mainBall)
    }

    func testSimulateFor_removesPegsWhenBallCollidesWithPeg() {
        let board = Board()
        board.setSize(boardSize: boardSize)
        _ = board.addPeg(at: CGPoint(x: 500, y: 500), color: .orange)
        gameEngine = PeggleGameEngine(board: board)

        let point = CGPoint(x: 500, y: 500)
        gameEngine.addBall(shootingTowards: point)

        // Simulate collision
        var totalTime = 20.0
        while totalTime > 0 {
            gameEngine.simulateFor(dt: Constants.physicsUpdateTickTime)
            totalTime -= Constants.physicsUpdateTickTime
        }

        XCTAssertTrue(gameEngine.pegs.isEmpty)
    }
}
