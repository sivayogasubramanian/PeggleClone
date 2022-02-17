//
//  Persistable.swift
//  PeggleClone
//
//  Created by Sivayogasubramanian on 25/1/22.
//

import CoreData

protocol Persistable {
    associatedtype CoreDataEntity: NSManagedObject

    /// Converts a core data entity to its respective model object.
    static func fromCoreDataEntity(_ entity: CoreDataEntity) -> Self

    /// Converts a model object to its respective core data entity.
    func toCoreDataEntity(using context: NSManagedObjectContext) -> CoreDataEntity
}
