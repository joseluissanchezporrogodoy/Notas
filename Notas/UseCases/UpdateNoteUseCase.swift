//
//  UpdateNoteUseCase.swift
//  Notas
//
//  Created by Jose Luis Sánchez-Porro on 21/5/24.
//

import Foundation

protocol UpdateNoteProtocol {
    func updateNoteWith(identifier: UUID, title: String, text: String?) throws
}
struct UpdateNoteUseCase: UpdateNoteProtocol {
    var notesDataBase: NotesDatabaseProtocol
    
    init(notesDataBase: NotesDatabaseProtocol = NotesDatabase.shared) {
        self.notesDataBase = notesDataBase
    }
    func updateNoteWith(identifier: UUID, title: String, text: String?) throws {
    
        try notesDataBase.update(identifier: identifier, title: title, text: text)
    }
}
