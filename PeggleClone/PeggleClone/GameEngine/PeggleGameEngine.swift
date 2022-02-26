//
//  PeggleGameEngine.swift
//  PeggleClone
//
//  Created by Sivayogasubramanian on 4/2/22.
//

import Foundation
import QuartzCore

class PeggleGameEngine {
    private let world: PhysicsWorld
    private let board: Board
    private(set) var ball: BallGameObject?
    private(set) var bucket: BucketGameObject
    private var pegObjects = [ObjectIdentifier: PegGameObject]()
    private var blockObjects = [ObjectIdentifier: BlockGameObject]()
    private var boardSize: CGSize
    private(set) var isReadyToShoot = true
    private(set) var offset = Double.zero
    private(set) var numberOfBallsLeft = 10
    var pegs: [PegGameObject] {
        Array(pegObjects.values)
    }
    var blocks: [BlockGameObject] {
        Array(blockObjects.values)
    }
    var isSpookyBallActive: Bool {
        pegs.filter({ $0.isLit && $0.color == .purple }).count > 0
    }
    var isBallOutOfBounds: Bool {
        guard let ball = ball else {
            return false
        }

        return ball.physicsBody.position.dy > max(board.maxHeight, boardSize.height - ball.radius)
    }
    var shouldRemoveBall: Bool {
        isBallOutOfBounds || (!isSpookyBallActive && bucket.isHit)
    }
    var isGameOver: Bool {
        numberOfBallsLeft <= 0
    }
    var isGameWon: Bool {
        pegs.filter({ $0.color == .orange }).count <= 0
    }

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
        self.ball = ball
        world.addPhysicsBody(ball.physicsBody)
        isReadyToShoot.toggle()
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
            pegObjects.removeValue(forKey: ObjectIdentifier(peg))
        }

        for block in blocks where block.isLit {
            world.removePhysicsBody(block.physicsBody)
            blockObjects.removeValue(forKey: ObjectIdentifier(block))
        }
    }

    private func addPegToPhysicsEngine(_ peg: PegGameObject) {
        pegObjects[ObjectIdentifier(peg)] = peg
        world.addPhysicsBody(peg.physicsBody)
    }

    private func addBlockToPhysicsEngine(_ block: BlockGameObject) {
        blockObjects[ObjectIdentifier(block)] = block
        world.addPhysicsBody(block.physicsBody)
    }

    private func removeNearbyGameObjectsIfBallStationary() {
        for peg in pegs where peg.shouldBeRemoved {
            world.removePhysicsBody(peg.physicsBody)
            pegObjects.removeValue(forKey: ObjectIdentifier(peg))
        }

        for block in blocks where block.shouldBeRemoved {
            world.removePhysicsBody(block.physicsBody)
            blockObjects.removeValue(forKey: ObjectIdentifier(block))
        }
    }

    private func removeBallIfBallExited() {
        guard let ball = ball else {
            return
        }

        if shouldRemoveBall {
            if bucket.isHit {
                SoundManager.shared.playSound(sound: .hitBucket)
                numberOfBallsLeft += 1
            }
            removeBall(ball: ball)
        }
    }

    private func resetHitCountOfGameObjects() {
        ball?.physicsBody.resetHitCount()
        bucket.physicsBody.resetHitCount()
        pegs.forEach({ $0.physicsBody.resetHitCount() })
        blocks.forEach({ $0.physicsBody.resetHitCount() })
    }

    private func prepareNewBall(initialDirection point: CGPoint) -> BallGameObject? {
        let ball = BallGameObject(
            position: CGVector(dx: boardSize.width / 2, dy: PhysicsConstants.initialBallLaunchYCoordinate)
        )
        let direction = (point.toCGVector() - ball.physicsBody.position).normalize()
        ball.physicsBody.setForce(to: PhysicsConstants.gravity, isMovable: true)
        ball.physicsBody.setVelocity(
            to: direction * PhysicsConstants.initialBallLaunchVelocityMultiplier,
            isMovable: true
        )

        return ball
    }

    private func removeBall(ball: BallGameObject) {
        self.ball = nil
        offset = .zero
        world.removePhysicsBody(ball.physicsBody)
        removeLitGameObjects()
        resetHitCountOfGameObjects()
        isReadyToShoot.toggle()
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
}
