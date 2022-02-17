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
    private(set) var snapshot = Data()
    private(set) var boardSize = CGSize.zero

    var canSave: Bool {
        !name.isEmpty
    }

    convenience init() {
        self.init(uuid: UUID(), name: "", pegs: [])
    }

    init(uuid: UUID, name: String, pegs: [Peg]) {
        self.uuid = uuid
        self.name = name
        self.pegs = pegs
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

    func addPeg(at point: CGPoint, color: PegColor?, bounds: CGSize) {
        guard let color = color else {
            return
        }

        let newPeg = Peg(color: color, center: point)
        guard validateAddPeg(newPeg: newPeg, bounds: bounds) else {
            return
        }

        pegs.append(newPeg)
    }

    func deletePeg(peg: Peg) {
        pegs.removeAll(where: { $0 === peg })
    }

    func removeAllPegs() {
        pegs = []
    }

    func movePeg(peg: Peg, to newCenter: CGPoint, bounds: CGSize) {
        guard let index = pegs.firstIndex(where: { $0 === peg }) else {
            return
        }

        let currentPeg = pegs[index]
        guard validateMovePeg(peg: currentPeg, newCenter: newCenter, bounds: bounds) else {
            return
        }

        currentPeg.changeCenter(to: newCenter)
    }
}

// MARK: Validation Methods
extension Board {
    private func validateAddPeg(newPeg: Peg, bounds: CGSize) -> Bool {
        guard isPegWithinBounds(peg: newPeg, bounds: bounds) else {
            return false
        }

        guard !isNewPegOverlappingWithExisitingPegs(newPeg: newPeg) else {
            return false
        }

        return true
    }

    private func validateMovePeg(peg: Peg, newCenter: CGPoint, bounds: CGSize) -> Bool {
        let minX = Peg.radius, maxX = bounds.width - Peg.radius
        let minY = Peg.radius, maxY = bounds.height - Peg.radius

        guard newCenter.isWithinBounds(minX: minX, maxX: maxX, minY: minY, maxY: maxY) else {
            return false
        }

        guard !isAnyPegPresent(at: newCenter, excludingPeg: peg) else {
            return false
        }

        return true
    }

    private func isNewPegOverlappingWithExisitingPegs(newPeg: Peg) -> Bool {
        for peg in pegs where arePegsOverlapping(peg1: peg, peg2: newPeg) {
            return true
        }
        return false
    }

    private func isAnyPegPresent(at point: CGPoint, excludingPeg: Peg) -> Bool {
        for peg in pegs where peg !== excludingPeg && isPegOverlapping(peg: peg, at: point) {
            return true
        }
        return false
    }

    private func isNameValid(name: String) -> Bool {
        guard !name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            return false
        }
        return true
    }

    private func arePegsOverlapping(peg1: Peg, peg2: Peg) -> Bool {
        isPegOverlapping(peg: peg1, at: peg2.center)
    }

    private func isPegOverlapping(peg: Peg, at point: CGPoint) -> Bool {
        let distance = peg.center.distance(toPoint: point)
        return distance.isLessThanOrEqualTo(Peg.diameter)
    }

    private func isPegWithinBounds(peg: Peg, bounds: CGSize) -> Bool {
        let minX = Peg.radius, maxX = bounds.width - Peg.radius
        let minY = Peg.radius, maxY = bounds.height - Peg.radius
        return peg.center.isWithinBounds(minX: minX, maxX: maxX, minY: minY, maxY: maxY)
    }
}
