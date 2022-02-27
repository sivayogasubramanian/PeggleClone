//
//  TestCoreDataManager.swift
//  PeggleCloneTests
//
//  Created by Sivayogasubramanian on 29/1/22.
//

import CoreData
@testable import PeggleClone

/// This is a TestCoreDataManager that writes to "/dev/null" instead of using the default SQLite storage mechanism.
/// This class therefore, should only be used in tests.
class TestCoreDataManager {
    let persistentStoreContainer: NSPersistentContainer
    let viewContext: NSManagedObjectContext

    init() {
        persistentStoreContainer = NSPersistentContainer(name: Constants.coreDataContainerName)

        let persistentStoreDescription = NSPersistentStoreDescription()
        persistentStoreDescription.url = URL(fileURLWithPath: "/dev/null")
        persistentStoreContainer.persistentStoreDescriptions = [persistentStoreDescription]

        persistentStoreContainer.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Unable to load test core data stores. Error: \(error.localizedDescription)")
            }
        }

        viewContext = persistentStoreContainer.viewContext
    }
}
