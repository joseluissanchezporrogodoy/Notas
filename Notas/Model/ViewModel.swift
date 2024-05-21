//
//  ViewModel.swift
//  Notas
//
//  Created by Jose Luis Sánchez-Porro on 21/5/24.
//

import Foundation
import Observation

@Observable
class ViewModel {
    var notes: [Note]
    
    var createNoteUseCase: CreateNoteUseCase
    var fetchAllUseCase: FetchAllNotesUseCase
    
    init(notes: [Note] = [],
         createNoteUseCase: CreateNoteUseCase = CreateNoteUseCase(),
         fetchAllNotesUseCase: FetchAllNotesUseCase = FetchAllNotesUseCase()) {
        self.notes = notes
        self.createNoteUseCase = createNoteUseCase
        self.fetchAllUseCase = fetchAllNotesUseCase
        fetchAllNotes()
    }
    
    func createNoteWith(title: String, text: String) {
        do {
            try createNoteUseCase.createNoteWith(title: title, text: text)
            fetchAllNotes()
        } catch {
            print("Error \(error.localizedDescription)")
        }
    }
    
    func fetchAllNotes() {
        do {
            notes = try fetchAllUseCase.fetchAll()
        } catch {
            print("Error \(error.localizedDescription)")
        }
    
    }
    
    func updateNoteWith(identifier: UUID, newTitle: String, newText: String?) {
        if let index = notes.firstIndex(where: {$0.identifier == identifier}) {
            let updateNote = Note(identifier: identifier, title: newTitle, text: newText, createAt: notes[index].createAt)
            notes[index] = updateNote
        }
    }
    
    func removeNoteWith(identifier: UUID) {
        notes.removeAll(where: {$0.identifier == identifier})
    }
}
