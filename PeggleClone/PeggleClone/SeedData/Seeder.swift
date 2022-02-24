//
//  Seeder.swift
//  PeggleClone
//
//  Created by Sivayogasubramanian on 24/2/22.
//

import Foundation
import CoreGraphics

class Seeder {
    let size: CGSize

    init(for size: CGSize) {
        self.size = size
    }

    func makeSeedLevels() -> [Board] {
        var boards: [Board] = []

        boards.append(makeLevelOneUsingStandardUnits())
        boards.append(makeLevelTwoUsingStandardUnits())
        boards.append(makeLevelThreeUsingStandardUnits())

        return boards
    }

    private func makeLevelOneUsingStandardUnits() -> Board {
        let board = Board()
        board.setSize(boardSize: size)
        board.setName(to: "Preset Level: A Level")

        var (initialX, initialY) = (3.5, 1.0)
        while initialX > 0.0 && initialY < Double(Constants.yRatio) {
            initialX -= 0.25
            initialY += 0.5
            let coordinate = CGPoint(x: getXCoordinate(for: initialX), y: getYCoordinate(for: initialY))
            _ = board.addPeg(at: coordinate, color: .blue)
        }

        (initialX, initialY) = (3.5, 1.0)
        while initialX < Double(Constants.xRatio) && initialY < Double(Constants.yRatio) {
            initialX += 0.25
            initialY += 0.5
            let coordinate = CGPoint(x: getXCoordinate(for: initialX), y: getYCoordinate(for: initialY))
            _ = board.addPeg(at: coordinate, color: .blue)
        }

        (initialX, initialY) = (1.75, 4.5)
        let maximumX = 5.25
        while initialX < maximumX {
            initialX += 0.25
            let coordinate = CGPoint(x: getXCoordinate(for: initialX), y: getYCoordinate(for: initialY))
            _ = board.addPeg(at: coordinate, color: .orange)
        }

        _ = board.addPeg(at: CGPoint(x: getXCoordinate(for: 3.5), y: getYCoordinate(for: 1.0)), color: .blue)
        return board
    }

    private func makeLevelTwoUsingStandardUnits() -> Board {
        let board = Board()
        board.setSize(boardSize: size)
        board.setName(to: "Preset Level: Diamond Matrix")

        for xUnit in 1...Constants.xRatio - 1 {
            board.setBoardOffset(to: -100)

            for yUnit in 1...Constants.yRatio - 1 {
                let coordinate = CGPoint(x: getXCoordinate(for: Double(xUnit)), y: getYCoordinate(for: Double(yUnit)))
                let color: PeggleColor = yUnit.isMultiple(of: 2) ? .blue : .orange

                if xUnit.isMultiple(of: 2) {
                    _ = board.addPeg(at: coordinate, color: color)
                } else {
                    _ = board.addBlock(at: coordinate, color: color)
                }
            }
        }

        board.setBoardOffset(to: .infinity)
        return board
    }

    private func makeLevelThreeUsingStandardUnits() -> Board {
        let board = Board()
        board.setSize(boardSize: size)
        board.setName(to: "Preset Level: Oscillating Madness")

        for xUnit in 1...Constants.xRatio - 1 {
            for yUnit in 1...(Constants.yRatio - 1) * 10 {
                let coordinate = CGPoint(x: getXCoordinate(for: Double(xUnit)), y: getYCoordinate(for: Double(yUnit)))
                let color: PeggleColor = (xUnit + yUnit).isMultiple(of: 2) ? .blue : .orange

                let block = board.addBlock(at: coordinate, color: color)
                block?.setSpringiness(to: PhysicsConstants.maximumSpringiness)
            }
        }

        board.setBoardOffset(to: -(size.height))

        for xUnit in 1...Constants.xRatio - 1 {
            for yUnit in 1...(Constants.yRatio - 1) * 10 {
                let coordinate = CGPoint(x: getXCoordinate(for: Double(xUnit)), y: getYCoordinate(for: Double(yUnit)))
                let color: PeggleColor = (xUnit + yUnit).isMultiple(of: 2) ? .blue : .orange

                _ = board.addPeg(at: coordinate, color: color)
            }
        }

        board.setBoardOffset(to: .infinity)
        return board
    }

    private func getXCoordinate(for standardUnit: Double) -> Double {
        Double(standardUnit) * (Double(size.width) / Double(Constants.xRatio))
    }

    private func getYCoordinate(for standardUnit: Double) -> Double {
        Double(standardUnit) * (Double(size.height) / Double(Constants.yRatio)) + Constants.letterBoxYOffset
    }
}
