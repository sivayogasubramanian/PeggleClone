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

    func addPeg(at point: CGPoint, color: PegColor?) {
        board.addPeg(at: point, color: color, bounds: boardSize)
        updateViews()
    }

    func movePeg(peg: Peg, to newCenter: CGPoint) {
        board.movePeg(peg: peg, to: newCenter, bounds: boardSize)
        updateViews()
    }

    func deletePeg(peg: Peg) {
        board.deletePeg(peg: peg)
        updateViews()
    }

    /// Sets the board for the view model. To be used when loading a board from storage.
    func setBoard(to board: Board) {
        self.board = board
        isNewBoard = false
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
