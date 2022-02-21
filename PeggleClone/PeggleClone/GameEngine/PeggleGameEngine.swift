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
    private(set) var ball: BallGameObject?
    private var pegObjects = [ObjectIdentifier: PegGameObject]()
    private var blockObjects = [ObjectIdentifier: BlockGameObject]()
    private var boardSize: CGSize
    private(set) var isReadyToShoot = true
    var pegs: [PegGameObject] {
        Array(pegObjects.values)
    }
    var blocks: [BlockGameObject] {
        Array(blockObjects.values)
    }

    init(board: Board) {
        boardSize = board.boardSize
        world = PhysicsWorld()

        // Left boundary
        world.addPhysicsBody(
            LinePhysicsBody(start: CGVector(dx: 0, dy: 0), end: CGVector(dx: 0, dy: boardSize.height))
        )
        // Right boundary
        world.addPhysicsBody(
            LinePhysicsBody(
                start: CGVector(dx: boardSize.width, dy: 0),
                end: CGVector(dx: boardSize.width, dy: boardSize.height)
            )
        )
        // Top boundary
        world.addPhysicsBody(
            LinePhysicsBody(
                start: CGVector(dx: 0, dy: 0),
                end: CGVector(dx: boardSize.width, dy: 0)
            )
        )

        board.pegs.forEach({ addPegToPhysicsEngine(PegGameObject(fromPeg: $0)) })
        board.blocks.forEach({ addBlockToPhysicsEngine(BlockGameObject(fromBlock: $0)) })
    }

    func addBall(shootingTowards point: CGPoint) {
        guard isReadyToShoot, let ball = prepareNewBall(initialDirection: point) else {
            return
        }
        self.ball = ball
        world.addPhysicsBody(ball.physicsBody)
        isReadyToShoot.toggle()
    }

    func simulateFor(dt deltaTime: TimeInterval) {
        // Physics Engine Operations
        world.updatePhysicsBodiesPositions(dt: deltaTime)
        world.resolveCollisions()

        // Peggle Specific Operations
        removeBallIfBallExited()
        removeNearbyGameObjectsIfBallStationary()
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

        let shouldRemoveBall = ball.physicsBody.position.dy > boardSize.height - ball.radius

        if shouldRemoveBall {
            removeBall(ball: ball)
        }
    }

    private func removeLitGameObjectsIfBallExited() {
        for peg in pegs where peg.isHit {
            world.removePhysicsBody(peg.physicsBody)
            pegObjects.removeValue(forKey: ObjectIdentifier(peg))
        }

        for block in blocks where block.isHit {
            world.removePhysicsBody(block.physicsBody)
            blockObjects.removeValue(forKey: ObjectIdentifier(block))
        }
    }

    private func resetHitCountOfGameObjects() {
        ball?.physicsBody.resetHitCount()
        pegs.forEach({ $0.physicsBody.resetHitCount() })
        blocks.forEach({ $0.physicsBody.resetHitCount() })
    }

    private func prepareNewBall(initialDirection point: CGPoint) -> BallGameObject? {
        let ball = BallGameObject(
            position: CGVector(dx: boardSize.width / 2, dy: PhysicsConstants.initialBallLaunchYCoordinate)
        )
        let direction = (point.toCGVector() - ball.physicsBody.position).normalize()
        ball.physicsBody.setForce(to: PhysicsConstants.gravity)
        ball.physicsBody.setVelocity(to: direction * PhysicsConstants.initialBallLaunchVelocityMultiplier)

        return ball
    }

    private func removeBall(ball: BallGameObject) {
        self.ball = nil
        world.removePhysicsBody(ball.physicsBody)
        removeLitGameObjectsIfBallExited()
        resetHitCountOfGameObjects()
        isReadyToShoot.toggle()
    }
}
