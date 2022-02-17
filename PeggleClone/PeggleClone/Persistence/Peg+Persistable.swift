//
//  Peg+Persistable.swift
//  PeggleClone
//
//  Created by Sivayogasubramanian on 25/1/22.
//

import CoreData
import CoreGraphics
import Foundation

extension Peg: Persistable {
    static func fromCoreDataEntity(_ entity: PegEntity) -> Self {
        let uuid = entity.uuid, color = entity.color
        let center = CGPoint(x: entity.xCoord, y: entity.yCoord)

        return self.init(uuid: uuid, color: color, center: center)
    }

    func toCoreDataEntity(using context: NSManagedObjectContext) -> PegEntity {
        let entity = PegEntity(context: context)
        assignAttributesToEntity(entity)
        return entity
    }

    private func assignAttributesToEntity(_ entity: PegEntity) {
        entity.setId(to: uuid)
        entity.setColor(to: color)
        entity.setXCoord(to: Double(center.x))
        entity.setYCoord(to: Double(center.y))
    }
}
