//
//  Board+Persistable.swift
//  PeggleClone
//
//  Created by Sivayogasubramanian on 25/1/22.
//

import CoreData
import CoreGraphics
import Foundation

extension Board: Persistable {
    static func fromCoreDataEntity(_ entity: BoardEntity) -> Self {
        let uuid = entity.uuid, name = entity.name, image = entity.snapshot
        let pegs = Array(entity.boardPegEntities).map({ Peg.fromCoreDataEntity($0) })

        let board = self.init(uuid: uuid, name: name, pegs: pegs)
        board.setImage(to: image)
        board.setSize(boardSize: CGSize(width: entity.width, height: entity.height))

        return board
    }

    func toCoreDataEntity(using context: NSManagedObjectContext) -> BoardEntity {
        let entity = BoardEntity(context: context)
        assignAttributesToEntity(entity, context: context)
        return entity
    }

    private func assignAttributesToEntity(_ entity: BoardEntity, context: NSManagedObjectContext) {
        entity.setId(to: uuid)
        entity.setName(to: name)
        entity.setSnapshot(to: snapshot)
        entity.setWidth(to: Double(boardSize.width))
        entity.setHeight(to: Double(boardSize.height))
        pegs.forEach { peg in
            entity.addToBoardPegEntities(peg.toCoreDataEntity(using: context))
        }
    }
}
