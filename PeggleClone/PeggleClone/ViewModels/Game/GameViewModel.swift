//
//  GameViewModel.swift
//  PeggleClone
//
//  Created by Sivayogasubramanian on 4/2/22.
//

import Foundation
import CoreGraphics
import QuartzCore
import UIKit
import SwiftUI

class GameViewModel: ObservableObject {
    private(set) var displaylink: CADisplayLink?
    private(set) var gameEngine: PeggleGameEngine
    private(set) var board: Board
    var pegs: [PegGameObject] {
        gameEngine.pegs
    }
    var blocks: [BlockGameObject] {
        gameEngine.blocks
    }
    var ball: BallGameObject? {
        gameEngine.ball
    }
    var isCannonLoaded: Bool {
        gameEngine.isReadyToShoot
    }
    var boardWidth: CGFloat {
        board.boardSize.width
    }
    var boardHeight: CGFloat {
        board.boardSize.height
    }
    var offset: Double {
        gameEngine.offset
    }

    // Game loop variables
    private(set) var previousTime = Date().timeIntervalSince1970
    private(set) var lag = 0.0

    init(board: Board) {
        self.board = board
        gameEngine = PeggleGameEngine(board: board)
    }

    deinit {
        displaylink?.invalidate()
        displaylink = nil
    }

    func shootBallTowards(point: CGPoint) {
        gameEngine.addBall(shootingTowards: point)
    }

    func getAngleForCanon(using point: CGPoint) -> Angle {
        let centerVector = CGVector(dx: boardWidth / 2, dy: boardHeight) - CGVector(dx: boardWidth / 2, dy: 0)
        let centerToPoint = point.toCGVector() - CGVector(dx: boardWidth / 2, dy: 0)
        let sine = centerVector.cross(vector: centerToPoint) / (centerVector.length() * centerToPoint.length())
        return Angle(radians: asin(sine))
    }

    func setOffset(using newY: Double) {
        guard board.maxHeight > boardHeight + Constants.yCoordinatePadding else {
            return
        }

        let maxOffset = board.maxHeight - boardHeight
        if newY > boardHeight / 2 {
            gameEngine.setOffset(to: -min(maxOffset, newY - boardHeight / 2))
        }
    }

    func startSimulation() {
        createDisplayLink()
    }

    private func createDisplayLink() {
        let displaylink = CADisplayLink(target: self, selector: #selector(step))
        displaylink.add(to: .current, forMode: .common)
        self.displaylink = displaylink
        previousTime = Date().timeIntervalSince1970

    }

    @objc private func step(displaylink: CADisplayLink) {
        let current = Date().timeIntervalSince1970
        let elasped = current - previousTime
        previousTime = current
        lag += elasped

        while lag >= PhysicsConstants.physicsUpdateTickTime {
            gameEngine.simulateFor(dt: PhysicsConstants.physicsUpdateTickTime)
            lag -= PhysicsConstants.physicsUpdateTickTime
        }

        updateViews()
    }

    private func updateViews() {
        objectWillChange.send()
    }
}
