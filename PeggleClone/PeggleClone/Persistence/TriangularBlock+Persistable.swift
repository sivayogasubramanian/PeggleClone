//
//  TriangularBlock+Persistable.swift
//  PeggleClone
//
//  Created by Sivayogasubramanian on 21/2/22.
//

import CoreData
import CoreGraphics
import Foundation

extension TriangularBlock: Persistable {
    static func fromCoreDataEntity(_ entity: TriangularBlockEntity) -> Self {
        let uuid = entity.uuid, color = entity.color, width = entity.width, height = entity.height
        let center = CGVector(dx: entity.xCoord, dy: entity.yCoord)

        let block = self.init(uuid: uuid, color: color, center: center)
        block.changeWidth(to: width)
        block.changeHeight(to: height)
        return block
    }

    func toCoreDataEntity(using context: NSManagedObjectContext) -> TriangularBlockEntity {
        let entity = TriangularBlockEntity(context: context)
        assignAttributesToEntity(entity)
        return entity
    }

    private func assignAttributesToEntity(_ entity: TriangularBlockEntity) {
        entity.setId(to: uuid)
        entity.setColor(to: color)
        entity.setXCoord(to: Double(center.dx))
        entity.setYCoord(to: Double(center.dy))
        entity.setWidth(to: width)
        entity.setHeight(to: height)
    }
}
