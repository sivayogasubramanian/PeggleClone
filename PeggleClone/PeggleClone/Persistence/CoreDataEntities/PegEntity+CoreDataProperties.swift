//
//  PegEntity+CoreDataProperties.swift
//  PeggleClone
//
//  Created by Sivayogasubramanian on 28/1/22.
//
//

import CoreData
import Foundation

extension PegEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PegEntity> {
        NSFetchRequest<PegEntity>(entityName: "PegEntity")
    }

    @NSManaged public private(set) var uuid: UUID
    @NSManaged private(set) var color: PeggleColor
    @NSManaged private(set) var xCoord: Double
    @NSManaged private(set) var yCoord: Double
    @NSManaged private(set) var radius: Double
    @NSManaged private(set) var boardEntity: BoardEntity
}

extension PegEntity: Identifiable {
    func setId(to uuid: UUID) {
        self.uuid = uuid
    }

    func setColor(to color: PeggleColor) {
        self.color = color
    }

    func setXCoord(to xCoord: Double) {
        self.xCoord = xCoord
    }

    func setYCoord(to yCoord: Double) {
        self.yCoord = yCoord
    }

    func setRadius(to radius: Double) {
        self.radius = radius
    }
}
