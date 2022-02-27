//
//  Peg+Persistable.swift
//  PeggleClone
//
//  Created by Sivayogasubramanian on 25/1/22.
//

import CoreData
import CoreGraphics

extension Peg: Persistable {
    static func fromCoreDataEntity(_ entity: PegEntity) -> Self {
        let uuid = entity.uuid, color = entity.color, radius = entity.radius
        let center = CGVector(dx: entity.xCoord, dy: entity.yCoord), rotation = entity.rotation

        return self.init(uuid: uuid, color: color, center: center, radius: radius, rotation: rotation)
    }

    func toCoreDataEntity(using context: NSManagedObjectContext) -> PegEntity {
        let entity = PegEntity(context: context)
        assignAttributesToEntity(entity)
        return entity
    }

    private func assignAttributesToEntity(_ entity: PegEntity) {
        entity.setId(to: uuid)
        entity.setColor(to: color)
        entity.setXCoord(to: Double(center.dx))
        entity.setYCoord(to: Double(center.dy))
        entity.setRadius(to: radius)
        entity.setRotation(to: rotation)
    }
}
