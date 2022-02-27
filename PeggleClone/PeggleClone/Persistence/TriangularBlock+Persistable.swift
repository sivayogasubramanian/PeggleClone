//
//  TriangularBlock+Persistable.swift
//  PeggleClone
//
//  Created by Sivayogasubramanian on 21/2/22.
//

import CoreData
import CoreGraphics

extension TriangularBlock: Persistable {
    static func fromCoreDataEntity(_ entity: TriangularBlockEntity) -> Self {
        let uuid = entity.uuid, color = entity.color, width = entity.width, height = entity.height
        let center = CGVector(dx: entity.xCoord, dy: entity.yCoord), rotation = entity.rotation
        let springiness = entity.springiness

        return self.init(uuid: uuid, color: color,
                         center: center, width: width, height: height,
                         rotation: rotation, springiness: springiness)
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
        entity.setRotation(to: rotation)
        entity.setSpringiness(to: springiness)
    }
}
