//
//  NotesDatabase.swift
//  Notas
//
//  Created by Jose Luis Sánchez-Porro on 21/5/24.
//

import Foundation
import SwiftData

enum DataBaseError: Error {
    case errorInsert
    case errorFetch
    case errorUpdate
    case errorRemove
}

protocol NotesDatabaseProtocol {
    func insert(note: Note) throws
    func fetchAll() throws -> [Note]
    func update(identifier: UUID, title: String, text: String?) throws
    func remove(identifier: UUID) throws
}

class NotesDatabase: NotesDatabaseProtocol {
   
    static let shared: NotesDatabase = NotesDatabase()
    
    @MainActor
    
    var contairner: ModelContainer = setupContainer(inMemory: false)
    
    private init() {
        
    }
    
    @MainActor
    static func setupContainer(inMemory: Bool) -> ModelContainer {
        do {
            let container = try ModelContainer(for: Note.self, configurations: ModelConfiguration(isStoredInMemoryOnly: inMemory))
            container.mainContext.autosaveEnabled = true
            return container
        } catch {
            print ("Error: \(error.localizedDescription)")
            fatalError()
        }
    }
    
    @MainActor
    func insert(note: Note) throws {
        contairner.mainContext.insert(note)
        do {
            try contairner.mainContext.save()
        } catch {
            print("Error \(error.localizedDescription)")
            throw DataBaseError.errorInsert
        }
    }
    
    @MainActor
    func fetchAll() throws -> [Note] {
        let fetchDescriptor = FetchDescriptor<Note>(sortBy: [SortDescriptor<Note>(\.createAt)])
        
        do {
            return try contairner.mainContext.fetch(fetchDescriptor)
        } catch {
            print("Error \(error.localizedDescription)")
            throw DataBaseError.errorFetch
        }
    }
    
    @MainActor
    func update(identifier: UUID, title: String, text: String?) throws {
        let notePredicate = #Predicate<Note> {
            $0.identifier == identifier
        }
        
        var fetchDescriptor = FetchDescriptor<Note>(predicate: notePredicate)
        fetchDescriptor.fetchLimit = 1
        
        do {
            guard let updateNote = try contairner.mainContext.fetch(fetchDescriptor).first else {
                throw DataBaseError.errorUpdate
            }
            
            updateNote.title = title
            updateNote.text = text
            
            try contairner.mainContext.save()
        } catch {
            print("Error al actualizar")
            throw DataBaseError.errorUpdate
        }
    }
    
    @MainActor
    func remove(identifier: UUID) throws {
        let notePredicate = #Predicate<Note> {
            $0.identifier == identifier
        }
        
        var fetchDescriptor = FetchDescriptor<Note>(predicate: notePredicate)
        fetchDescriptor.fetchLimit = 1
        
        do {
            guard let deleteNote = try contairner.mainContext.fetch(fetchDescriptor).first else {
                throw DataBaseError.errorRemove
            }
            
            
            contairner.mainContext.delete(deleteNote)
            try contairner.mainContext.save()
        } catch {
            print("Error al actualizar")
            throw DataBaseError.errorRemove
        }
    }
    
}
