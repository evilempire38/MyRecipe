//
//  CoreDataStack.swift
//  MyRecipe
//
//  Created by Андрей Коноплёв on 22.02.2022.
//

import Foundation
import CoreData

class CoreDataStack {
    lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "MyRecipe")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}



