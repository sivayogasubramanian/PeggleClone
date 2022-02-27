//
//  PeggleGameEngine.swift
//  PeggleClone
//
//  Created by Sivayogasubramanian on 4/2/22.
//

import Foundation
import QuartzCore

class PeggleGameEngine {
    let world: PhysicsWorld
    let board: Board
    private(set) var boardSize: CGSize
    private(set) var pegs = [PegGameObject]()
    private(set) var blocks = [BlockGameObject]()
    private(set) var balls = [BallGameObject]()
    private(set) var mainBall: BallGameObject?
    private(set) var bucket: BucketGameObject
    private(set) var offset = Double.zero
    private(set) var numberOfBallsLeft = 10
    private(set) var score = 0

    init(board: Board) {
        self.board = board
        boardSize = board.boardSize
        world = PhysicsWorld()
        bucket = BucketGameObject(
            position: CGVector(
                dx: boardSize.width / 2,
                dy: max(board.maxHeight, boardSize.height) + Constants.bucketYCoordinateOffset
            )
        )

        // Left boundary
        world.addPhysicsBody(
            LinePhysicsBody(start: CGVector(dx: 0, dy: 0),
                            end: CGVector(dx: 0, dy: max(board.maxHeight, boardSize.height)))
        )
        // Right boundary
        world.addPhysicsBody(
            LinePhysicsBody(
                start: CGVector(dx: boardSize.width, dy: 0),
                end: CGVector(dx: boardSize.width, dy: max(board.maxHeight, boardSize.height))
            )
        )
        // Top boundary
        world.addPhysicsBody(
            LinePhysicsBody(
                start: CGVector(dx: 0, dy: 0),
                end: CGVector(dx: boardSize.width, dy: 0)
            )
        )

        world.addPhysicsBody(bucket.physicsBody)
        board.pegs.forEach({ addPegToPhysicsEngine(PegGameObject(fromPeg: $0)) })
        board.blocks.forEach({ addBlockToPhysicsEngine(BlockGameObject(fromBlock: $0)) })
    }

    func addBall(shootingTowards point: CGPoint) {
        guard isReadyToShoot && !isGameOver && !isGameWon, let ball = prepareNewBall(initialDirection: point) else {
            return
        }
        numberOfBallsLeft -= 1
        self.mainBall = ball
        world.addPhysicsBody(ball.physicsBody)
    }

    func simulateFor(dt deltaTime: TimeInterval) {
        // Physics Engine Operations
        world.updatePhysicsBodiesPositions(dt: deltaTime)
        world.resolveCollisions()

        // Peggle Specific Operations
        applyPowerups()
        removeBallIfBallExited()
        removeNearbyGameObjectsIfBallStationary()
    }

    func setOffset(to offset: Double) {
        self.offset = offset
    }

    func removeLitGameObjects() {
        for peg in pegs where peg.isLit {
            world.removePhysicsBody(peg.physicsBody)
        }

        pegs.removeAll(where: { $0.isLit })
    }

    func addExtraBall(_ ball: BallGameObject) {
        balls.append(ball)
        world.addPhysicsBody(ball.physicsBody)
    }

    func updateScore() {
        score += Utils.getScoreWhenPegHit(pegs: pegs)
    }

    func removeBallIfBallExited() {
        guard let ball = mainBall else {
            return
        }

        if shouldRemoveMainBall {
            if bucket.isHit {
                SoundManager.shared.playSound(sound: .hitBucket)
                numberOfBallsLeft += 1
            }
            updateScore()
            removeBall(ball: ball)
        }
    }

    func setMainBall(to ball: BallGameObject) {
        mainBall = ball
    }

    private func addPegToPhysicsEngine(_ peg: PegGameObject) {
        pegs.append(peg)
        world.addPhysicsBody(peg.physicsBody)
    }

    private func addBlockToPhysicsEngine(_ block: BlockGameObject) {
        blocks.append(block)
        world.addPhysicsBody(block.physicsBody)
    }

    private func removeNearbyGameObjectsIfBallStationary() {
        for peg in pegs where peg.shouldBeRemoved {
            world.removePhysicsBody(peg.physicsBody)
        }

        for block in blocks where block.shouldBeRemoved {
            world.removePhysicsBody(block.physicsBody)
        }

        pegs.removeAll(where: { $0.shouldBeRemoved })
        blocks.removeAll(where: { $0.shouldBeRemoved })
    }

    private func resetHitCountOfGameObjects() {
        mainBall?.physicsBody.resetHitCount()
        bucket.physicsBody.resetHitCount()
        pegs.forEach({ $0.physicsBody.resetHitCount() })
        blocks.forEach({ $0.physicsBody.resetHitCount() })
    }

    private func prepareNewBall(initialDirection point: CGPoint) -> BallGameObject? {
        let ball = BallGameObject(
            position: CGVector(dx: boardSize.width / 2, dy: Constants.initialBallLaunchYCoordinate)
        )
        let direction = (point.toCGVector() - ball.physicsBody.position).normalize()
        ball.physicsBody.setForce(to: Constants.gravity, isMovable: true)
        ball.physicsBody.setVelocity(
            to: direction * Constants.initialBallLaunchVelocity,
            isMovable: true
        )

        return ball
    }

    private func removeBall(ball: BallGameObject) {
        self.mainBall = nil
        offset = .zero
        world.removePhysicsBody(ball.physicsBody)
        removeLitGameObjects()
        resetHitCountOfGameObjects()
        removeAllExtraBalls()
    }

    private func applyPowerups() {
        for peg in pegs {
            guard peg.isLit else {
                continue
            }

            if let powerup = peg.powerup {
                powerup.applyPowerup(hitPeg: peg, gameEngine: self)
            }
        }
    }

    private func removeAllExtraBalls() {
        for ball in balls {
            world.removePhysicsBody(ball.physicsBody)
        }
        balls.removeAll()
    }
}
