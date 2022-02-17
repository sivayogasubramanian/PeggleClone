//
//  BoardEntity+CoreDataProperties.swift
//  PeggleClone
//
//  Created by Sivayogasubramanian on 28/1/22.
//
//

import CoreData
import Foundation

extension BoardEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BoardEntity> {
        NSFetchRequest<BoardEntity>(entityName: "BoardEntity")
    }

    @NSManaged public private(set) var uuid: UUID
    @NSManaged private(set) var name: String
    @NSManaged private(set) var width: Double
    @NSManaged private(set) var height: Double
    @NSManaged private(set) var snapshot: Data
    @NSManaged private(set) var boardPegEntities: Set<PegEntity>
}

// MARK: Generated accessors for boardPegEntities
extension BoardEntity {

    @objc(addBoardPegEntitiesObject:)
    @NSManaged public func addToBoardPegEntities(_ value: PegEntity)

    @objc(removeBoardPegEntitiesObject:)
    @NSManaged public func removeFromBoardPegEntities(_ value: PegEntity)

    @objc(addBoardPegEntities:)
    @NSManaged public func addToBoardPegEntities(_ values: Set<PegEntity>)

    @objc(removeBoardPegEntities:)
    @NSManaged public func removeFromBoardPegEntities(_ values: Set<PegEntity>)

}

extension BoardEntity: Identifiable {
    func setId(to uuid: UUID) {
        self.uuid = uuid
    }

    func setName(to name: String) {
        self.name = name
    }

    func setSnapshot(to snapshot: Data) {
        self.snapshot = snapshot
    }

    func setWidth(to width: Double) {
        self.width = width
    }

    func setHeight(to height: Double) {
        self.height = height
    }
}
