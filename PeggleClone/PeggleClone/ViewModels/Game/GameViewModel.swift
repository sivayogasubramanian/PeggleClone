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
    private var board: Board
    var pegs: [PegGameObject] {
        gameEngine.pegs
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

    func startSimulation() {
        createDisplayLink()
    }

    private func createDisplayLink() {
        let displaylink = CADisplayLink(target: self, selector: #selector(step))
        displaylink.add(to: .current, forMode: .common)
        self.displaylink = displaylink
    }

    @objc private func step(displaylink: CADisplayLink) {
        gameEngine.simulateFor(dt: displaylink.targetTimestamp - displaylink.timestamp)
        updateViews()
    }

    private func updateViews() {
        objectWillChange.send()
    }
}
