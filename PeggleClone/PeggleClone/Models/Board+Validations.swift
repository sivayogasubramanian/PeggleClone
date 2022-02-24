//
//  Board+Validations.swift
//  PeggleClone
//
//  Created by Sivayogasubramanian on 24/2/22.
//

import Foundation
import CoreGraphics

/// This extension contains validation methods for the main Board model.
internal extension Board {
    func isNameValid(name: String) -> Bool {
        guard !name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            return false
        }
        return true
    }

    func validateAddPeg(peg: Peg, bounds: CGSize) -> Bool {
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

    func validateAddBlock(block: TriangularBlock, bounds: CGSize) -> Bool {
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

    func isOverlappingWithExisitingPegs(peg newPeg: Peg) -> Bool {
        for peg in pegs where areOverlapping(peg1: peg, peg2: newPeg) {
            return true
        }
        return false
    }

    func isOverlappingWithExisitingBlocks(peg newPeg: Peg) -> Bool {
        for block in blocks where isOverlapping(block: block, peg: newPeg) {
            return true
        }
        return false
    }

    func isOverlappingWithExisitingPegs(block newBlock: TriangularBlock) -> Bool {
        for peg in pegs where isOverlapping(block: newBlock, peg: peg) {
            return true
        }
        return false
    }

    func isOverlappingWithExisitingBlocks(block newBlock: TriangularBlock) -> Bool {
        for block in blocks where areOverlapping(block1: newBlock, block2: block) {
            return true
        }
        return false
    }

    func isAnyPegPresentThatOverlaps(peg currentPeg: Peg, excludePeg: Peg) -> Bool {
        for peg in pegs where peg !== excludePeg && areOverlapping(peg1: currentPeg, peg2: peg) {
            return true
        }
        return false
    }

    func isAnyBlockPresentThatOverlaps(peg: Peg) -> Bool {
        for block in blocks where isOverlapping(block: block, peg: peg) {
            return true
        }
        return false
    }

    func isAnyPegPresentThatOverlaps(block: TriangularBlock) -> Bool {
        for peg in pegs where isOverlapping(block: block, peg: peg) {
            return true
        }
        return false
    }

    func isAnyBlockPresentThatOverlaps(
        block currentBlock: TriangularBlock, excludeBlock: TriangularBlock
    ) -> Bool {
        for block in blocks where block !== excludeBlock && areOverlapping(block1: currentBlock, block2: block) {
            return true
        }
        return false
    }

    func isOverlapping(block: TriangularBlock, peg: Peg) -> Bool {
        let manifold = Intersector.detectBetween(polygon: block, circle: peg)
        return manifold.hasCollided
    }

    func areOverlapping(peg1: Peg, peg2: Peg) -> Bool {
        let manifold = Intersector.detectBetween(circle1: peg1, circle2: peg2)
        return manifold.hasCollided
    }

    func areOverlapping(block1: TriangularBlock, block2: TriangularBlock) -> Bool {
        let manifold = Intersector.detectBetween(polygon1: block1, polygon2: block2)
        return manifold.hasCollided
    }

    func isWithinBounds(peg: Peg, bounds: CGSize) -> Bool {
        let minX = peg.radius, maxX = bounds.width - peg.radius
        let minY = Constants.letterBoxYOffset + peg.radius, maxY = bounds.height - peg.radius - boardHeightOffset
        return peg.center.isWithinBounds(minX: minX, maxX: maxX, minY: minY, maxY: maxY)
    }

    func isWithinBounds(block: TriangularBlock, bounds: CGSize) -> Bool {
        let minX = CGFloat.zero, maxX = bounds.width
        let minY = Constants.letterBoxYOffset, maxY = bounds.height - boardHeightOffset

        for vertex in block.vertices where !vertex.isWithinBounds(minX: minX, maxX: maxX, minY: minY, maxY: maxY) {
            return false
        }

        return true
    }
}
