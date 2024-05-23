//
//  RemoveNoteUseCase.swift
//  Notas
//
//  Created by Jose Luis Sánchez-Porro on 21/5/24.
//

import Foundation

protocol RemoveNoteProtocol {
    func removeNoteWith(identifier: UUID) throws
}
struct RemoveNoteUseCase: RemoveNoteProtocol {
   
    var notesDataBase: NotesDatabaseProtocol
    
    init(notesDataBase: NotesDatabaseProtocol = NotesDatabase.shared) {
        self.notesDataBase = notesDataBase
    }
    func removeNoteWith(identifier: UUID) throws {
        try notesDataBase.remove(identifier: identifier)
    }
    
}
