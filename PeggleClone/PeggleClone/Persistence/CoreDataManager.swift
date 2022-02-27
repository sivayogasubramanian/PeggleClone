//
//  CoreDataManager.swift
//  PeggleClone
//
//  Created by Sivayogasubramanian on 25/1/22.
//

import CoreData

class CoreDataManager {
    private let persistentStoreContainer: NSPersistentContainer
    private static let shared = CoreDataManager()

    private init() {
        persistentStoreContainer = NSPersistentContainer(name: Constants.coreDataContainerName)
        persistentStoreContainer.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Unable to load core data stores. Error: \(error.localizedDescription)")
            }
        }
    }

    static var viewContext: NSManagedObjectContext {
        CoreDataManager.shared.persistentStoreContainer.viewContext
    }
}
