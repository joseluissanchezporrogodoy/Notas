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
    var databaseError: DataBaseError?
    
    var createNoteUseCase: CreateNoteProtocol
    var fetchAllUseCase: FetchAllNotesProtocol
    var updateNoteUseCase: UpdateNoteProtocol
    var removeNoteUseCase: RemoveNoteProtocol
    
    
    init(notes: [Note] = [],
         createNoteUseCase: CreateNoteProtocol = CreateNoteUseCase(),
         fetchAllNotesUseCase: FetchAllNotesProtocol = FetchAllNotesUseCase(),
         updateNoteUseCase: UpdateNoteProtocol = UpdateNoteUseCase(),
         removeNoteUseCase: RemoveNoteProtocol = RemoveNoteUseCase()) {
        self.notes = notes
        self.createNoteUseCase = createNoteUseCase
        self.fetchAllUseCase = fetchAllNotesUseCase
        self.updateNoteUseCase = updateNoteUseCase
        self.removeNoteUseCase = removeNoteUseCase
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
        do {
            try updateNoteUseCase.updateNoteWith(identifier: identifier, title: newTitle, text: newText)
        } catch {
            print("Error \(error.localizedDescription)")
        }
    }
    
    func removeNoteWith(identifier: UUID) {
        do {
            try removeNoteUseCase.removeNoteWith(identifier: identifier)
            fetchAllNotes()
        } catch let error as DataBaseError {
            print("Error \(error.localizedDescription)")
            databaseError = error
        } catch {
            print("Error \(error.localizedDescription)")
        }
    }
}
