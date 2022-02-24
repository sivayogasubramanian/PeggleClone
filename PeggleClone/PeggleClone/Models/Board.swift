//
//  Board.swift
//  PeggleClone
//
//  Created by Sivayogasubramanian on 22/1/22.
//

import CoreGraphics
import Foundation

final class Board: Identifiable {
    let uuid: UUID
    private(set) var name: String
    private(set) var pegs: [Peg]
    private(set) var blocks: [TriangularBlock]
    private(set) var snapshot = Data()
    private(set) var boardSize = CGSize.zero

    var canSave: Bool {
        !name.isEmpty
    }

    convenience init() {
        self.init(uuid: UUID(), name: "", pegs: [], blocks: [])
    }

    init(uuid: UUID, name: String, pegs: [Peg], blocks: [TriangularBlock]) {
        self.uuid = uuid
        self.name = name
        self.pegs = pegs
        self.blocks = blocks
    }

    func setName(to name: String) {
        guard isNameValid(name: name) else {
            return
        }

        self.name = name
    }

    func setImage(to imageData: Data?) {
        guard let data = imageData else {
            return
        }

        snapshot = .init(data)
    }

    func setSize(boardSize: CGSize) {
        self.boardSize = boardSize
    }

    func addPeg(at point: CGPoint, color: PeggleColor?) -> Peg? {
        guard let color = color else {
            return nil
        }

        let newPeg = Peg(color: color, center: point.toCGVector(), radius: Constants.pegRadius, rotation: .zero)
        guard validateAddPeg(peg: newPeg, bounds: boardSize) else {
            return nil
        }

        pegs.append(newPeg)
        return newPeg
    }

    func addBlock(at point: CGPoint, color: PeggleColor?) -> TriangularBlock? {
        guard let color = color else {
            return nil
        }

        let newBlock = TriangularBlock(color: color, center: point.toCGVector(), width: Constants.blockWidth,
                                       height: Constants.blockHeight, rotation: .zero, springiness: 0)
        guard validateAddBlock(block: newBlock, bounds: boardSize) else {
            return nil
        }

        blocks.append(newBlock)
        return newBlock
    }

    func deletePeg(peg: Peg) {
        pegs.removeAll(where: { $0 === peg })
    }

    func deleteBlock(block: TriangularBlock) {
        blocks.removeAll(where: { $0 === block })
    }

    func removeAllPegs() {
        pegs = []
        blocks = []
    }

    func movePeg(peg: Peg, to newCenter: CGPoint) {
        guard let index = pegs.firstIndex(where: { $0 === peg }) else {
            return
        }

        let currentPeg = pegs[index]
        movePegToClosestValidLocation(peg: currentPeg, to: newCenter, bounds: boardSize)
    }

    func moveBlock(block: TriangularBlock, to newCenter: CGPoint) {
        guard let index = blocks.firstIndex(where: { $0 === block }) else {
            return
        }

        let currentBlock = blocks[index]
        moveBlockToClosestValidLocation(block: currentBlock, to: newCenter, bounds: boardSize)
    }

    func setRotation(peg: Peg, to rotation: Double) -> Bool {
        let rotatedPeg = Peg(color: peg.color, center: peg.center, radius: peg.radius, rotation: rotation)

        guard !isAnyPegPresentThatOverlaps(peg: rotatedPeg, excludePeg: peg)
                && !isAnyBlockPresentThatOverlaps(peg: rotatedPeg) else {
            return false
        }

        guard isWithinBounds(peg: rotatedPeg, bounds: boardSize) else {
            return false
        }

        peg.setRotation(to: rotation)
        return true
    }

    func setRotation(block: TriangularBlock, to rotation: Double) -> Bool {
        let rotatedBlock = TriangularBlock(color: block.color, center: block.center, width: block.width,
                                           height: block.height, rotation: rotation,
                                           springiness: block.springiness)

        guard !isAnyPegPresentThatOverlaps(block: rotatedBlock)
                && !isAnyBlockPresentThatOverlaps(block: rotatedBlock, excludeBlock: block) else {
            return false
        }

        guard isWithinBounds(block: rotatedBlock, bounds: boardSize) else {
            return false
        }

        block.setRotation(to: rotation)
        return true
    }

    func setPegRadius(peg: Peg, to radius: Double) -> Bool {
        let resizedPeg = Peg(color: peg.color, center: peg.center, radius: radius, rotation: peg.rotation)

        guard  !isAnyPegPresentThatOverlaps(peg: resizedPeg, excludePeg: peg)
                && !isAnyBlockPresentThatOverlaps(peg: resizedPeg) else {
            return false
        }

        guard isWithinBounds(peg: resizedPeg, bounds: boardSize) else {
            return false
        }

        peg.setRadius(to: radius)
        return true
    }

    func setBlockWidth(block: TriangularBlock, to width: Double) -> Bool {
        let resizedBlock = TriangularBlock(color: block.color, center: block.center, width: width,
                                           height: block.height, rotation: block.rotation,
                                           springiness: block.springiness)

        guard !isAnyPegPresentThatOverlaps(block: resizedBlock)
                && !isAnyBlockPresentThatOverlaps(block: resizedBlock, excludeBlock: block) else {
            return false
        }

        guard isWithinBounds(block: resizedBlock, bounds: boardSize) else {
            return false
        }

        block.setWidth(to: width)
        return true
    }

    func setBlockHeight(block: TriangularBlock, to height: Double) -> Bool {
        let resizedBlock = TriangularBlock(color: block.color, center: block.center, width: block.width,
                                           height: height, rotation: block.rotation,
                                           springiness: block.springiness)

        guard !isAnyPegPresentThatOverlaps(block: resizedBlock)
                && !isAnyBlockPresentThatOverlaps(block: resizedBlock, excludeBlock: block) else {
            return false
        }

        guard isWithinBounds(block: resizedBlock, bounds: boardSize) else {
            return false
        }

        block.setHeight(to: height)
        return true
    }

    func setBlockSpringiness(block: TriangularBlock, to springiness: Double) {
        if springiness == PhysicsConstants.zeroSpringiness {
            block.setSpringiness(to: PhysicsConstants.zeroSpringiness)
            return
        }

        if springiness < PhysicsConstants.minimumSpringiness {
            block.setSpringiness(to: PhysicsConstants.minimumSpringiness)
            return
        }

        if springiness > PhysicsConstants.maximumSpringiness {
            block.setSpringiness(to: PhysicsConstants.maximumSpringiness)
            return
        }

        block.setSpringiness(to: springiness)
    }

    func prepareGameplayBoard() -> Board {
        let board = Board()
        board.setSize(boardSize: boardSize)

        for peg in pegs {
            let gameCenter = CGVector(dx: peg.center.dx, dy: peg.center.dy + Constants.letterBoxYOffset)
            let gamePeg = Peg(color: peg.color, center: gameCenter,
                              radius: peg.radius, rotation: peg.rotation)
            board.pegs.append(gamePeg)
        }

        for block in blocks {
            let gameCenter = CGVector(dx: block.center.dx, dy: block.center.dy + Constants.letterBoxYOffset)
            let gameBlock = TriangularBlock(color: block.color, center: gameCenter,
                                            width: block.width, height: block.height,
                                            rotation: block.rotation, springiness: block.springiness)
            board.blocks.append(gameBlock)
        }

        return board
    }

    private func movePegToClosestValidLocation(peg: Peg, to newCenter: CGPoint, bounds: CGSize) {
        let direction = (peg.center - newCenter.toCGVector()).normalize()
        var currentPoint = newCenter.toCGVector()
        var movedPeg = Peg(color: peg.color, center: currentPoint, radius: peg.radius,
                           rotation: peg.rotation)

        while isAnyPegPresentThatOverlaps(peg: movedPeg, excludePeg: peg)
                || isAnyBlockPresentThatOverlaps(peg: movedPeg) {
            currentPoint += direction
            movedPeg = Peg(color: peg.color, center: currentPoint, radius: peg.radius,
                           rotation: peg.rotation)
        }

        guard isWithinBounds(peg: movedPeg, bounds: bounds) else {
            return
        }

        peg.setCenter(to: currentPoint)
    }

    private func moveBlockToClosestValidLocation(block: TriangularBlock, to newCenter: CGPoint, bounds: CGSize) {
        let direction = (block.center - newCenter.toCGVector()).normalize()
        var currentPoint = newCenter.toCGVector()
        var movedBlock = TriangularBlock(color: block.color, center: currentPoint, width: block.width,
                                         height: block.height, rotation: block.rotation,
                                         springiness: block.springiness)

        while isAnyPegPresentThatOverlaps(block: movedBlock)
                || isAnyBlockPresentThatOverlaps(block: movedBlock, excludeBlock: block) {
            currentPoint += direction
            movedBlock = TriangularBlock(color: block.color, center: currentPoint, width: block.width,
                                         height: block.height, rotation: block.rotation,
                                         springiness: block.springiness)
        }

        guard isWithinBounds(block: movedBlock, bounds: bounds) else {
            return
        }

        block.setCenter(to: currentPoint)
    }
}
