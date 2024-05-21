//
//  CreateNoteUseCase.swift
//  Notas
//
//  Created by Jose Luis Sánchez-Porro on 21/5/24.
//

import Foundation

struct CreateNoteUseCase {
    var notesDataBase: NotesDatabaseProtocol
    
    init(notesDataBase: NotesDatabaseProtocol = NotesDatabase.shared) {
        self.notesDataBase = notesDataBase
    }
    func createNoteWith(title: String, text: String) throws {
        let note: Note = .init(identifier: .init(), title: title, text: text, createAt: .now)
        try notesDataBase.insert(note: note )
    }
}
