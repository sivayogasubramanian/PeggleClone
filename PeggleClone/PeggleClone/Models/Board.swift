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
    private(set) var boardHeightOffset = 0.0

    var canSave: Bool {
        !name.isEmpty
    }
    var maxHeight: Double {
        var maximum = Double.zero

        maximum = pegs.reduce(maximum, { max($0, $1.center.dy) })
        maximum = blocks.reduce(maximum, { max($0, $1.center.dy) })

        return maximum + Constants.yCoordinatePadding
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

    func setBoardOffset(to offset: Double) {
        boardHeightOffset = min(.zero, boardHeightOffset + offset)
    }

    func addPeg(at point: CGPoint, color: PeggleColor?) -> Peg? {
        guard let color = color else {
            return nil
        }
        let center = CGVector(dx: point.x, dy: point.y - boardHeightOffset)
        let newPeg = Peg(color: color, center: center, radius: Constants.pegRadius, rotation: .zero)
        guard validateAddPeg(peg: newPeg, bounds: boardSize) else {
            return nil
        }

        addPeg(newPeg)
        return newPeg
    }

    func addBlock(at point: CGPoint, color: PeggleColor?) -> TriangularBlock? {
        guard let color = color else {
            return nil
        }

        let center = CGVector(dx: point.x, dy: point.y - boardHeightOffset)
        let newBlock = TriangularBlock(color: color, center: center, width: Constants.blockWidth,
                                       height: Constants.blockHeight, rotation: .zero, springiness: 0)
        guard validateAddBlock(block: newBlock, bounds: boardSize) else {
            return nil
        }

        addBlock(newBlock)
        return newBlock
    }

    func addPeg(_ peg: Peg) {
        pegs.append(peg)
    }

    func addBlock(_ block: TriangularBlock) {
        blocks.append(block)
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
        if springiness == Constants.zeroSpringiness {
            block.setSpringiness(to: Constants.zeroSpringiness)
            return
        }

        if springiness < Constants.minimumSpringiness {
            block.setSpringiness(to: Constants.minimumSpringiness)
            return
        }

        if springiness > Constants.maximumSpringiness {
            block.setSpringiness(to: Constants.maximumSpringiness)
            return
        }

        block.setSpringiness(to: springiness)
    }

    private func movePegToClosestValidLocation(peg: Peg, to newCenter: CGPoint, bounds: CGSize) {
        var currentPoint = CGVector(dx: newCenter.x, dy: newCenter.y - boardHeightOffset)
        let direction = (peg.center - currentPoint).normalize()
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
        var currentPoint = CGVector(dx: newCenter.x, dy: newCenter.y - boardHeightOffset)
        let direction = (block.center - currentPoint).normalize()
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
