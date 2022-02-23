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

    func addPeg(at point: CGPoint, color: PeggleColor?, bounds: CGSize) -> Peg? {
        guard let color = color else {
            return nil
        }

        let newPeg = Peg(color: color, center: point.toCGVector(), radius: Constants.pegRadius, rotation: .zero)
        guard validateAddPeg(peg: newPeg, bounds: bounds) else {
            return nil
        }

        pegs.append(newPeg)
        return newPeg
    }

    func addBlock(at point: CGPoint, color: PeggleColor?, bounds: CGSize) -> TriangularBlock? {
        guard let color = color else {
            return nil
        }

        let newBlock = TriangularBlock(color: color, center: point.toCGVector(), width: Constants.blockWidth,
                                       height: Constants.blockHeight, rotation: .zero)
        guard validateAddBlock(block: newBlock, bounds: bounds) else {
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

    func movePeg(peg: Peg, to newCenter: CGPoint, bounds: CGSize) {
        guard let index = pegs.firstIndex(where: { $0 === peg }) else {
            return
        }

        let currentPeg = pegs[index]
        movePegToClosestValidLocation(peg: currentPeg, to: newCenter, bounds: bounds)
    }

    func moveBlock(block: TriangularBlock, to newCenter: CGPoint, bounds: CGSize) {
        guard let index = blocks.firstIndex(where: { $0 === block }) else {
            return
        }

        let currentBlock = blocks[index]
        moveBlockToClosestValidLocation(block: currentBlock, to: newCenter, bounds: bounds)
    }

    func setRotation(peg: Peg, to rotation: Double) -> Bool {
        let rotatedPeg = Peg(color: peg.color, center: peg.center, radius: peg.radius, rotation: rotation)

        guard !isAnyPegPresentThatOverlaps(peg: rotatedPeg, excludePeg: peg)
                && !isAnyBlockPresentThatOverlaps(peg: rotatedPeg) else {
            return false
        }

        peg.setRotation(to: rotation)
        return true
    }

    func setRotation(block: TriangularBlock, to rotation: Double) -> Bool {
        let rotatedBlock = TriangularBlock(color: block.color, center: block.center, width: block.width,
                                           height: block.height, rotation: rotation)

        guard !isAnyPegPresentThatOverlaps(block: rotatedBlock)
                && !isAnyBlockPresentThatOverlaps(block: rotatedBlock, excludeBlock: block) else {
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

        peg.setRadius(to: radius)
        return true
    }

    func setBlockWidth(block: TriangularBlock, to width: Double) -> Bool {
        let resizedBlock = TriangularBlock(color: block.color, center: block.center, width: width,
                                           height: block.height, rotation: block.rotation)

        guard !isAnyPegPresentThatOverlaps(block: resizedBlock)
                && !isAnyBlockPresentThatOverlaps(block: resizedBlock, excludeBlock: block) else {
            return false
        }

        block.setWidth(to: width)
        return true
    }

    func setBlockHeight(block: TriangularBlock, to height: Double) -> Bool {
        let resizedBlock = TriangularBlock(color: block.color, center: block.center, width: block.width,
                                           height: height, rotation: block.rotation)

        guard !isAnyPegPresentThatOverlaps(block: resizedBlock)
                && !isAnyBlockPresentThatOverlaps(block: resizedBlock, excludeBlock: block) else {
            return false
        }

        block.setHeight(to: height)
        return true
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

        guard validateMovePeg(peg: movedPeg, bounds: bounds) else {
            return
        }

        peg.setCenter(to: currentPoint)
    }

    private func moveBlockToClosestValidLocation(block: TriangularBlock, to newCenter: CGPoint, bounds: CGSize) {
        let direction = (block.center - newCenter.toCGVector()).normalize()
        var currentPoint = newCenter.toCGVector()
        var movedBlock = TriangularBlock(color: block.color, center: currentPoint, width: block.width,
                                         height: block.height, rotation: block.rotation)

        while isAnyPegPresentThatOverlaps(block: movedBlock)
                || isAnyBlockPresentThatOverlaps(block: movedBlock, excludeBlock: block) {
            currentPoint += direction
            movedBlock = TriangularBlock(color: block.color, center: currentPoint, width: block.width,
                                         height: block.height, rotation: block.rotation)
        }

        guard validateMoveBlock(block: movedBlock, bounds: bounds) else {
            return
        }

        block.setCenter(to: currentPoint)
    }
}

// MARK: Validation Methods
extension Board {
    private func isNameValid(name: String) -> Bool {
        guard !name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            return false
        }
        return true
    }

    private func validateAddPeg(peg: Peg, bounds: CGSize) -> Bool {
        guard isWithinBounds(peg: peg, bounds: bounds) else {
            return false
        }

        guard !isOverlappingWithExisitingPegs(peg: peg) else {
            return false
        }

        guard !isOverlappingWithExisitingBlocks(peg: peg) else {
            return false
        }

        return true
    }

    private func validateAddBlock(block: TriangularBlock, bounds: CGSize) -> Bool {
        guard isWithinBounds(block: block, bounds: bounds) else {
            return false
        }

        guard !isOverlappingWithExisitingPegs(block: block) else {
            return false
        }

        guard !isOverlappingWithExisitingBlocks(block: block) else {
            return false
        }

        return true
    }

    private func validateMovePeg(peg: Peg, bounds: CGSize) -> Bool {
        isWithinBounds(peg: peg, bounds: bounds)
    }

    private func validateMoveBlock(block: TriangularBlock, bounds: CGSize) -> Bool {
        isWithinBounds(block: block, bounds: bounds)
    }

    private func isOverlappingWithExisitingPegs(peg newPeg: Peg) -> Bool {
        for peg in pegs where areOverlapping(peg1: peg, peg2: newPeg) {
            return true
        }
        return false
    }

    private func isOverlappingWithExisitingBlocks(peg newPeg: Peg) -> Bool {
        for block in blocks where isOverlapping(block: block, peg: newPeg) {
            return true
        }
        return false
    }

    private func isOverlappingWithExisitingPegs(block newBlock: TriangularBlock) -> Bool {
        for peg in pegs where isOverlapping(block: newBlock, peg: peg) {
            return true
        }
        return false
    }

    private func isOverlappingWithExisitingBlocks(block newBlock: TriangularBlock) -> Bool {
        for block in blocks where areOverlapping(block1: newBlock, block2: block) {
            return true
        }
        return false
    }

    private func isAnyPegPresentThatOverlaps(peg currentPeg: Peg, excludePeg: Peg) -> Bool {
        for peg in pegs where peg !== excludePeg && areOverlapping(peg1: currentPeg, peg2: peg) {
            return true
        }
        return false
    }

    private func isAnyBlockPresentThatOverlaps(peg: Peg) -> Bool {
        for block in blocks where isOverlapping(block: block, peg: peg) {
            return true
        }
        return false
    }

    private func isAnyPegPresentThatOverlaps(block: TriangularBlock) -> Bool {
        for peg in pegs where isOverlapping(block: block, peg: peg) {
            return true
        }
        return false
    }

    private func isAnyBlockPresentThatOverlaps(
        block currentBlock: TriangularBlock, excludeBlock: TriangularBlock
    ) -> Bool {
        for block in blocks where block !== excludeBlock && areOverlapping(block1: currentBlock, block2: block) {
            return true
        }
        return false
    }

    private func isOverlapping(block: TriangularBlock, peg: Peg) -> Bool {
        let manifold = Intersector.detectBetween(polygon: block, circle: peg)
        return manifold.hasCollided
    }

    private func areOverlapping(peg1: Peg, peg2: Peg) -> Bool {
        let manifold = Intersector.detectBetween(circle1: peg1, circle2: peg2)
        return manifold.hasCollided
    }

    private func areOverlapping(block1: TriangularBlock, block2: TriangularBlock) -> Bool {
        let manifold = Intersector.detectBetween(polygon1: block1, polygon2: block2)
        return manifold.hasCollided
    }

    private func isWithinBounds(peg: Peg, bounds: CGSize) -> Bool {
        let minX = peg.radius, maxX = bounds.width - peg.radius
        let minY = peg.radius, maxY = bounds.height - peg.radius
        return peg.center.isWithinBounds(minX: minX, maxX: maxX, minY: minY, maxY: maxY)
    }

    private func isWithinBounds(block: TriangularBlock, bounds: CGSize) -> Bool {
        let minX = CGFloat.zero, maxX = bounds.width
        let minY = CGFloat.zero, maxY = bounds.height

        for vertex in block.vertices where !vertex.isWithinBounds(minX: minX, maxX: maxX, minY: minY, maxY: maxY) {
            return false
        }

        return true
    }
}
