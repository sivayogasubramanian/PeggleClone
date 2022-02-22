//
//  DesignerViewModel.swift
//  PeggleClone
//
//  Created by Sivayogasubramanian on 20/1/22.
//

import CoreData
import CoreGraphics
import Foundation

class DesignerViewModel: ObservableObject {
    private(set) var board = Board()
    private(set) var isNewBoard = true
    private(set) var boardSize: CGSize = .zero
    private(set) var rotation: Double = .zero
    private(set) var selectedPeg: Peg?
    private(set) var selectedBlock: TriangularBlock?

    func addPeg(at point: CGPoint, color: PeggleColor?) {
        let peg = board.addPeg(at: point, color: color, bounds: boardSize)
        setSelectedPeg(peg)
        updateViews()
    }

    func addBlock(at point: CGPoint, color: PeggleColor?) {
        let block = board.addBlock(at: point, color: color, bounds: boardSize)
        setSelectedBlock(block)
        updateViews()
    }

    func movePeg(peg: Peg, to newCenter: CGPoint) {
        board.movePeg(peg: peg, to: newCenter, bounds: boardSize)
        updateViews()
    }

    func moveBlock(block: TriangularBlock, to newCenter: CGPoint) {
        board.moveBlock(block: block, to: newCenter, bounds: boardSize)
        updateViews()
    }

    func deletePeg(peg: Peg) {
        board.deletePeg(peg: peg)
        rotation = .zero
        updateViews()
    }

    func deleteBlock(block: TriangularBlock) {
        board.deleteBlock(block: block)
        rotation = .zero
        updateViews()
    }

    /// Sets the board for the view model. To be used when loading a board from storage.
    func setBoard(to board: Board) {
        self.board = board
        isNewBoard = false
        rotation = 0.0
        updateViews()
    }

    func setBoardName(to name: String) {
        board.setName(to: name)
        updateViews()
    }

    func setBoardSize(to size: CGSize) {
        board.setSize(boardSize: size)
        boardSize = size
    }

    func setImageData(from view: DesignerBoardView) {
        board.setImage(to: view.asImage(size: boardSize).pngData())
    }

    func resetDesigner() {
        board = Board()
        setBoardSize(to: boardSize)
        isNewBoard = true
        rotation = .zero
        updateViews()
    }

    func resetSelectedObjects() {
        selectedPeg = nil
        selectedBlock = nil
    }

    func setSelectedPeg(_ peg: Peg?) {
        selectedBlock = nil

        if let peg = peg {
            rotation = peg.rotation
            selectedPeg = peg
        }

        updateViews()
    }

    func setSelectedBlock(_ block: TriangularBlock?) {
        selectedPeg = nil

        if let block = block {
            rotation = block.rotation
            selectedBlock = block
        }

        updateViews()
    }

    func setRotation(to rotation: Double) {
        if let peg = selectedPeg {
            if board.setRotation(peg: peg, to: rotation) {
                self.rotation = rotation
            }
        }

        if let block = selectedBlock {
            if board.setRotation(block: block, to: rotation) {
                self.rotation = rotation
            }
        }

        updateViews()
    }

    func saveBoard(using context: NSManagedObjectContext = CoreDataManager.viewContext) {
        guard board.canSave else {
            return
        }

        if isNewBoard {
            createNewBoard(using: context)
        } else {
            updateCurrentBoard(using: context)
        }
    }

    func loadSavedLevels(using context: NSManagedObjectContext = CoreDataManager.viewContext) -> [Board] {
        let request = BoardEntity.fetchRequest()
        let sort = NSSortDescriptor(key: "name", ascending: true)
        request.sortDescriptors = [sort]

        let boardObjects = (try? context.fetch(request)) ?? []

        return boardObjects.map({ Board.fromCoreDataEntity($0) })
    }

    private func createNewBoard(using context: NSManagedObjectContext) {
        makeBoardNameUnique()
        _ = board.toCoreDataEntity(using: context)
        try? context.save()
    }

    private func updateCurrentBoard(using context: NSManagedObjectContext) {
        deleteCurrentBoard(using: context)
        createNewBoard(using: context)
    }

    private func deleteCurrentBoard(using context: NSManagedObjectContext) {
        let uuid = board.uuid.uuidString
        let request = BoardEntity.fetchRequest()
        request.predicate = NSPredicate(format: "uuid == %@", uuid)

        guard let objects = try? context.fetch(request) else {
            return
        }

        if let object = objects.first {
            context.delete(object)
        }
    }

    private func makeBoardNameUnique() {
        let boards = loadSavedLevels()
        var name = board.name

        while boards.contains(where: { $0.name == name }) {
            name += " copy"
        }

        board.setName(to: name)
    }

    private func updateViews() {
        objectWillChange.send()
    }
}
