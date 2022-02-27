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

    // For adjustment panel in designer
    private(set) var rotationSelection: Double = .zero
    private(set) var radiusSelection = Constants.pegRadius
    private(set) var widthSelection = Constants.blockWidth
    private(set) var heightSelection = Constants.blockHeight
    private(set) var showSpringinessCircle = false
    private(set) var selectedPeg: Peg?
    private(set) var selectedBlock: TriangularBlock?

    func addPeg(at point: CGPoint, color: PeggleColor?) -> Bool {
        let peg = board.addPeg(at: point, color: color)
        setSelectedPeg(peg)
        updateViews()
        return peg != nil
    }

    func addBlock(at point: CGPoint, color: PeggleColor?) -> Bool {
        let block = board.addBlock(at: point, color: color)
        setSelectedBlock(block)
        updateViews()
        return block != nil
    }

    func movePeg(peg: Peg, to newCenter: CGPoint) {
        board.movePeg(peg: peg, to: newCenter)
        setSelectedPeg(peg)
        updateViews()
    }

    func moveBlock(block: TriangularBlock, to newCenter: CGPoint) {
        board.moveBlock(block: block, to: newCenter)
        setSelectedBlock(block)
        updateViews()
    }

    func deletePeg(peg: Peg) {
        board.deletePeg(peg: peg)
        resetViewModelStates()
        updateViews()
    }

    func deleteBlock(block: TriangularBlock) {
        board.deleteBlock(block: block)
        resetViewModelStates()
        updateViews()
    }

    /// Sets the board for the view model. To be used when loading a board from storage.
    func setBoard(to board: Board) {
        self.board = board
        isNewBoard = false
        resetViewModelStates()
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
        resetViewModelStates()
        board.setImage(to: view.asImage(size: boardSize).pngData())
    }

    func setBoardOffset(to offset: Double) {
        board.setBoardOffset(to: offset)
        updateViews()
    }

    func resetDesigner() {
        board = Board()
        setBoardSize(to: boardSize)
        isNewBoard = true
        resetViewModelStates()
        updateViews()
    }

    func setSelectedPeg(_ peg: Peg?) {
        selectedBlock = nil

        if let peg = peg {
            rotationSelection = peg.rotation
            radiusSelection = peg.radius
            selectedPeg = peg
        }

        updateViews()
    }

    func setSelectedBlock(_ block: TriangularBlock?) {
        selectedPeg = nil

        if let block = block {
            rotationSelection = block.rotation
            widthSelection = block.width
            heightSelection = block.height
            showSpringinessCircle = block.springiness > 0
            selectedBlock = block
        }

        updateViews()
    }

    func setRotation(to rotation: Double) {
        if let peg = selectedPeg {
            if board.setRotation(peg: peg, to: rotation) {
                rotationSelection = rotation
            }
        }

        if let block = selectedBlock {
            if board.setRotation(block: block, to: rotation) {
                rotationSelection = rotation
            }
        }

        updateViews()
    }

    func setPegRadius(to radius: Double) {
        if let peg = selectedPeg {
            if board.setPegRadius(peg: peg, to: radius) {
                radiusSelection = radius
            }
        }

        updateViews()
    }

    func setBlockWidth(to width: Double) {
        if let block = selectedBlock {
            if board.setBlockWidth(block: block, to: width) {
                widthSelection = width
            }
        }

        updateViews()
    }

    func setBlockHeight(to height: Double) {
        if let block = selectedBlock {
            if board.setBlockHeight(block: block, to: height) {
                heightSelection = height
            }
        }

        updateViews()
    }

    func toggleSpringinessCircle() {
        showSpringinessCircle.toggle()
        guard let selectedBlock = selectedBlock else {
            return
        }

        if showSpringinessCircle {
            board.setBlockSpringiness(block: selectedBlock, to: PhysicsConstants.minimumSpringiness)
        } else {
            board.setBlockSpringiness(block: selectedBlock, to: PhysicsConstants.zeroSpringiness)
        }

        updateViews()
    }

    func setSpringiness(for block: TriangularBlock, location: CGPoint) {
        let springiness = block.center.distance(to: location.toCGVector())
        board.setBlockSpringiness(block: block, to: springiness)
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

        while Seeder.names.contains(name) || boards.contains(where: { $0.name == name }) {
            name += " copy"
        }

        board.setName(to: name)
    }

    private func resetViewModelStates() {
        selectedPeg = nil
        selectedBlock = nil
        rotationSelection = .zero
        radiusSelection = Constants.pegRadius
        widthSelection = Constants.blockWidth
        heightSelection = Constants.blockHeight
        showSpringinessCircle = false
    }

    private func updateViews() {
        objectWillChange.send()
    }
}
