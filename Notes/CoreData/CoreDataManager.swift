//
//  CoreDataManager.swift
//  Notes
//
//  Created by Кирилл  Геллерт on 03.02.2022.
//

import Foundation
import CoreData

class CoreDataManager {
    
    static let shared = CoreDataManager(modelName: "Notes")
    
    let persistentContainer: NSPersistentContainer
    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    init(modelName: String) {
        persistentContainer = NSPersistentContainer(name: modelName)
    }
    
    func load() {
        persistentContainer.loadPersistentStores { descriptiom, error in
            if let error = error {
                fatalError(error.localizedDescription)
            }
        }
    }
    
    func save() {
        if viewContext.hasChanges {
            do {
                try viewContext.save()
            } catch {
                print("Error while saving \(error.localizedDescription)")
            }
        }
    }
    
}

extension CoreDataManager {
    
    func createNote() -> Note {
        let note = Note(context: viewContext)
        note.id = UUID()
        note.lastUpdated = Date()
        note.text = ""
        save()
        return note
    }
    
    func getNotes(filter: String? = nil) -> [Note] {
        let request: NSFetchRequest<Note> = Note.fetchRequest()
        let sortDescriptor = NSSortDescriptor(keyPath: \Note.lastUpdated, ascending: false)
        request.sortDescriptors = [sortDescriptor]
        if let filter = filter {
            let predicate = NSPredicate(format: "text contains[cd] %@", filter)
            request.predicate = predicate
        }
        return (try? viewContext.fetch(request)) ?? []
    }
    
    func deleteNote(_ note: Note) {
        viewContext.delete(note)
        save()
    }
    
}
