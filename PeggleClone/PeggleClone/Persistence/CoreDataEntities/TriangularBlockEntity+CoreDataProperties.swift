//
//  TriangularBlockEntity+CoreDataProperties.swift
//  PeggleClone
//
//  Created by Sivayogasubramanian on 21/2/22.
//
//

import Foundation
import CoreData

extension TriangularBlockEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TriangularBlockEntity> {
        NSFetchRequest<TriangularBlockEntity>(entityName: "TriangularBlockEntity")
    }

    @NSManaged public private(set) var uuid: UUID
    @NSManaged private(set) var color: PeggleColor
    @NSManaged private(set) var width: Double
    @NSManaged private(set) var height: Double
    @NSManaged private(set) var xCoord: Double
    @NSManaged private(set) var yCoord: Double
    @NSManaged private(set) var rotation: Double
    @NSManaged private(set) var boardEntity: BoardEntity

}

extension TriangularBlockEntity: Identifiable {
    func setId(to uuid: UUID) {
        self.uuid = uuid
    }

    func setColor(to color: PeggleColor) {
        self.color = color
    }

    func setWidth(to width: Double) {
        self.width = width
    }

    func setHeight(to height: Double) {
        self.height = height
    }

    func setXCoord(to xCoord: Double) {
        self.xCoord = xCoord
    }

    func setYCoord(to yCoord: Double) {
        self.yCoord = yCoord
    }

    func setRotation(to rotation: Double) {
        self.rotation = rotation
    }
}
