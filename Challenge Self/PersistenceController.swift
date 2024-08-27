//
//  PersistenceController.swift
//  Challenge Self
//
//  Created by Kirills Galenko on 27/08/2024.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "ChallengeSelfModel") // Make sure this matches your model
        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores { storeDescription, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
    }

    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        
        // Create dummy data for preview
        for index in 0..<5 {
            let newGoal = GoalEntity(context: viewContext)
            newGoal.title = "Sample Goal \(index)"
            newGoal.complete = false
            newGoal.order = Int16(index)
        }

        do {
            try viewContext.save()
        } catch {
            fatalError("Unresolved error \(error)")
        }

        return result
    }()
}
