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
    private(set) var board: Board
    private(set) var gameEngine: PeggleGameEngine
    private(set) var timer: Timer?
    private(set) var displaylink: CADisplayLink?
    private(set) var timeLeft = 120
    var pegs: [PegGameObject] {
        gameEngine.pegs
    }
    var blocks: [BlockGameObject] {
        gameEngine.blocks
    }
    var balls: [BallGameObject] {
        gameEngine.balls
    }
    var ball: BallGameObject? {
        gameEngine.mainBall
    }
    var bucket: BucketGameObject {
        gameEngine.bucket
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
    var numberOfBallsLeft: Int {
        gameEngine.numberOfBallsLeft
    }
    var numberOfOrangePegsLeft: Int {
        gameEngine.numberOfOrangePegsLeft
    }
    var numberOfBluePegsLeft: Int {
        gameEngine.numberOfBluePegsLeft
    }
    var numberOfPurplePegsLeft: Int {
        gameEngine.numberOfPurplePegsLeft
    }
    var numberOfGrayPegsLeft: Int {
        gameEngine.numberOfGrayPegsLeft
    }
    var numberOfYellowPegsLeft: Int {
        gameEngine.numberOfYellowPegsLeft
    }
    var numberOfPinkPegsLeft: Int {
        gameEngine.numberOfPinkPegsLeft
    }
    var isGameWon: Bool {
        gameEngine.isGameWon
    }
    var isGameOver: Bool {
        gameEngine.isGameOver && ball == nil
    }
    var score: Int {
        gameEngine.score
    }
    var isTimeOver: Bool {
        timeLeft <= 0
    }

    // Game loop variables
    private(set) var previousTime = Date().timeIntervalSince1970
    private(set) var lag = 0.0

    init(board: Board) {
        self.board = board
        gameEngine = PeggleGameEngine(board: board)
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
        let halfHeight = boardHeight / 2
        if newY > halfHeight {
            gameEngine.setOffset(to: -min(maxOffset, newY - halfHeight))
        }
    }

    func startSimulation() {
        createDisplayLink()
    }

    func stopSimulation() {
        timer?.invalidate()
        displaylink?.invalidate()
        displaylink = nil
        timer = nil
    }

    private func createDisplayLink() {
        let displaylink = CADisplayLink(target: self, selector: #selector(step))
        let timer = Timer
            .scheduledTimer(timeInterval: 1, target: self, selector: #selector(gameTimer), userInfo: nil, repeats: true)
        displaylink.add(to: .current, forMode: .common)
        self.displaylink = displaylink
        self.timer = timer
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

    @objc private func gameTimer() {
        timeLeft -= 1
        timeLeft = max(timeLeft, 0)
    }

    private func updateViews() {
        objectWillChange.send()
    }
}
